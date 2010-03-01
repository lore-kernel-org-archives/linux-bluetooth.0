Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6aeb672b1001272156m678aa8fepec2498386947936a@mail.gmail.com>
References: <6aeb672b1001220212u518836fds5df2a7e3de8463bf@mail.gmail.com>
	 <6aeb672b1001272156m678aa8fepec2498386947936a@mail.gmail.com>
Date: Mon, 1 Mar 2010 17:54:15 +0800
Message-ID: <6aeb672b1003010154u6660632fj53fdbac2c8d0e302@mail.gmail.com>
Subject: Re: Kernel panic when handing Motorola S305 headset
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e644b91a60ff970480ba3b03
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e644b91a60ff970480ba3b03
Content-Type: text/plain; charset=ISO-8859-1

I'd like to continue the previous thread on that Motorola S305 causes
kernel panic because I did find some clue here. Sorry for misleading
guess one month ago if any.

Recap the problem here so that you don't to read the first long post.
The pattern to reproduce the issue is:
1. Pair the S305 headset from the phone or the PC( I am using a Ubuntu)
2. Remove pairing on the phone or PC
3. Power off and then power on S305.
4. The S305 will try to connect and since link key removed on this
side it will try to pair. Input 0000.
5. Kernel panic happens. This can be observed on kernel version
2.6.29(on the Droid phone, yes, it's a modified version),
2.6.31-19-generic on a Ubuntu and a pretty latest 2.6.33-020633rc8
from Ubuntu official RC release.

The exact kernel crash point is
             if (l2cap_check_security(sk)) {
                  if (bt_sk(sk)->defer_setup) {
                      struct sock *parent = bt_sk(sk)->parent;
                      rsp.result = cpu_to_le16(L2CAP_CR_PEND);
                      rsp.status = cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
>>>                   parent->sk_data_ready(parent, 0)
                  } else {

After tracing the issue for a couple of weeks, I find the difference
between a normal flow and the panic one. If the user space process
accepts the L2CAP connection request before L2CAP_INFO_RSP received,
the following calls will be carried out:

l2cap_sock_accept-> bt_accept_dequeue->bt_accept_unlink(in the branch
bt_sk(parent)->defer_setup)-> set bt_sk(sk)->parent = NULL. Later when
L2CAP_INFO_RSP arrives, the l2cap_conn_start() will try to call the
marked line above and de-referring NULL happen.

To fix this, shall we consider checking if a pending socket can be
accepted in bt_accept_dequeue() prior to a pending L2CAP_INFO_REQ
responded? For example,  adding a check to BT_CONNECT2 in
af_bluetooth.c.

215         if (sk->sk_state == BT_CONNECTED || !newsock ||
216                         ( bt_sk(parent)->defer_setup &&
(sk->sk_state != BT_CONNECT2))) {

Again, I am not sure if this will bring a side-effect. Please advise
the most appropriate way. Thanks.

p.s: I attached partial trace files for those who're interested to the traces.

--0016e644b91a60ff970480ba3b03
Content-Type: text/plain; charset=US-ASCII; name="s305-good-bad-trace.txt"
Content-Disposition: attachment; filename="s305-good-bad-trace.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g693azsd1

VHJhY2Ugd2hlbiBwYW5pYyBoYXBwZW5kZWQ6CjwzPlsgIDM1Ni43NTg0ODNdIGwyY2FwX2Nvbm5l
Y3RfcmVxOiBwc20gMHgxOSBzY2lkIDB4MDA0MQ0KPDM+WyAgMzU2Ljc2Mzg1NF0gbDJjYXBfY29u
bmVjdF9yZXE6IHBhcmVudCBjN2U4ZjYwMA0KPDM+WyAgMzU2Ljc2ODgyOV0gX19sMmNhcF9jaGFu
X2FkZDogY29ubiBjN2ZhMzdjMCwgcHNtIDB4MTksIGRjaWQgMHgwMDQxDQo8Mz5bICAzNTYuNzc1
NDgyXSBsMmNhcF9jb25uZWN0X3JlcTogYmVmb3JlIHJldHVybiwgc2sgYzVkNjZjMDAgcGFyZW50
IGM3ZThmNjAwDQo8Mz5bICAzNTYuNzgyODk3XSBsMmNhcF9jb25uZWN0X3JlcTogcHNtIDB4MDEg
c2NpZCAweDAwNDINCjwzPlsgIDM1Ni43ODgxNzddIGwyY2FwX2Nvbm5lY3RfcmVxOiBwYXJlbnQg
YzdlOGZlMDANCjwzPlsgIDM1Ni43OTMxMjFdIF9fbDJjYXBfY2hhbl9hZGQ6IGNvbm4gYzdmYTM3
YzAsIHBzbSAweDAxLCBkY2lkIDB4MDA0Mg0KPDM+WyAgMzU2Ljc5OTc3NF0gbDJjYXBfY29ubmVj
dF9yZXE6IGJlZm9yZSByZXR1cm4sIHNrIGM1ZDY2YTAwIHBhcmVudCBjN2U4ZmUwMA0KPDM+WyAg
MzU2LjgzNzE1OF0gbDJjYXBfc29ja19hY2NlcHQ6IG5ldyBzb2NrZXQgYzVkNjZjMDANCjwzPlsg
IDM1Ni44NDI1OTBdIGwyY2FwX2Nvbm5fc3RhcnQ6IEJUX0NPTk5FQ1RFMiwgc2sgYzVkNjZjMDAs
IHBhcmVudCAobnVsbCkKClRyYWNlIHdoZW4gZXZlcnl0aGluZyBnb2VzIG9uIHdlbGwuCjwzPlsg
IDY0MS4zOTM0NjNdIGwyY2FwX2Nvbm5lY3RfcmVxOiBwc20gMHgxOSBzY2lkIDB4MDA0MQo8Mz5b
ICA2NDEuMzk4OTU2XSBsMmNhcF9jb25uZWN0X3JlcTogcGFyZW50IGM3ZTkxMjAwCjwzPlsgIDY0
MS40MDM3NzhdIF9fbDJjYXBfY2hhbl9hZGQ6IGNvbm4gYzk1MTk0NDAsIHBzbSAweDE5LCBkY2lk
IDB4MDA0MQo8Mz5bICA2NDEuNDEwNDYxXSBsMmNhcF9jb25uZWN0X3JlcTogYmVmb3JlIHJldHVy
biwgc2sgYzk3ZTNhMDAgcGFyZW50IGM3ZTkxMjAwCjwzPlsgIDY0MS40MTc4NzddIGwyY2FwX2Nv
bm5lY3RfcmVxOiBwc20gMHgwMSBzY2lkIDB4MDA0Mgo8Mz5bICA2NDEuNDIzMTU2XSBsMmNhcF9j
b25uZWN0X3JlcTogcGFyZW50IGM2NGIwYzAwCjwzPlsgIDY0MS40MjgxMzFdIF9fbDJjYXBfY2hh
bl9hZGQ6IGNvbm4gYzk1MTk0NDAsIHBzbSAweDAxLCBkY2lkIDB4MDA0Mgo8Mz5bICA2NDEuNDM0
NzUzXSBsMmNhcF9jb25uZWN0X3JlcTogYmVmb3JlIHJldHVybiwgc2sgYzk3ZTM0MDAgcGFyZW50
IGM2NGIwYzAwCjwzPlsgIDY0MS40NzYxNjVdIGwyY2FwX2Nvbm5fc3RhcnQ6IEJUX0NPTk5FQ1RF
Miwgc2sgYzk3ZTNhMDAsIHBhcmVudCBjN2U5MTIwMAo8Mz5bICA2NDEuNDgzODU2XSBsMmNhcF9z
b2NrX2FjY2VwdDogbmV3IHNvY2tldCBjOTdlM2EwMAo8Mz5bICA2NDEuNTUxNTEzXSBsMmNhcF9z
b2NrX2FjY2VwdDogbmV3IHNvY2tldCBjOTdlMzQwMAo8Mz5bICA2NDEuNTkyNzQyXSBsMmNhcF9z
b2NrX3NodXRkb3duOiBzb2NrIGNlYTdhODQwLCBzayBjOTdlM2EwMCwgaG93IDIKPDM+WyAgNjQx
LjYwNzcyN10gbDJjYXBfc29ja19zaHV0ZG93bjogc29jayBjZWE3YTBjMCwgc2sgYzk3ZTM0MDAs
IGhvdyAyCjwzPlsgIDY0NC4wNTU0MTldIF9fbDJjYXBfY2hhbl9hZGQ6IGNvbm4gYzk1MTk0NDAs
IHBzbSAweDAxLCBkY2lkIDB4MDAwMAo8Mz5bICA2NTAuMDU1ODE2XSBsMmNhcF9zb2NrX3NodXRk
b3duOiBzb2NrIGNlYTdhMGMwLCBzayBjOTdlMzQwMCwgaG93IDIKPDM+WyAgNjUwLjA2MzAxOF0g
bDJjYXBfc29ja19zaHV0ZG93bjogc2stc2h1dGRvd24gPSB0cnVlCjwzPlsgIDY1MC4wNjk0Mjdd
IF9fbDJjYXBfc29ja19jbG9zZTogc2sgYzk3ZTM0MDAgc3RhdGUgMSBzb2NrZXQgY2VhN2EwYzAg
cmVhc29uIDAKCg==
--0016e644b91a60ff970480ba3b03--
