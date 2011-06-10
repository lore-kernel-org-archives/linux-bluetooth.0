Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110610055558.GA1832@dell>
References: <yunboy7a2so.fsf@aiko.keithp.com>
	<99B09243E1A5DA4898CDD8B700111448175AA2DB2A@EXMB04.eu.tieto.com>
	<20110609083345.GA2894@dell.ccr.corp.intel.com>
	<yuny61b3pnm.fsf@aiko.keithp.com>
	<99B09243E1A5DA4898CDD8B700111448175AA2DE98@EXMB04.eu.tieto.com>
	<20110610055558.GA1832@dell>
Date: Fri, 10 Jun 2011 14:58:50 +0900
Message-ID: <BANLkTim4F8ZvWPMHSXpcBj9Eb2uFThcz4w@mail.gmail.com>
Subject: Re: Regression caused by "Bluetooth: Map sec_level to link key requirements"
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Waldemar.Rymarkiewicz@tieto.com, keithp@keithp.com, padovan@profusion.mobi,
	marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

On Fri, Jun 10, 2011 at 2:55 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Thu, Jun 09, 2011, Waldemar.Rymarkiewicz@tieto.com wrote:
>> >I re-pair'ed using a manually entered a 16 digit pin, but now
>> >DUN setup doesn't succeed at all.
>>
>> Did you try to remove all stored link keys and start again?
>> If you already have a pincode which is insecure you have to remove it manually.
>>
>> Try 'hciconfig hciX noauth noencrypt ' before.
>>
>> Check syslog and switch debug on in the kernel first.
>
> So I just realized that the BITE tests were only done for mgmtops.c and
> not hciops.c. One critical difference is that conn->key_type will not be
> set (or actually set to 0xff) for connections which happen after the
> initial pairing has occurred. We're right now testing a one-line patch
> which might fix the issue. Luiz will send it soon if it turns out to
> work fine.

So the fix we were testing looks like this:

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2f5ae53..b309f84 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -673,8 +673,8 @@ auth:
        if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &conn->pend))
                return 0;

-       hci_conn_auth(conn, sec_level, auth_type);
-       return 0;
+       if (!(hci_conn_auth(conn, sec_level, auth_type)))
+               return 0;

 encrypt:
        if (conn->link_mode & HCI_LM_ENCRYPT)

-- 
Luiz Augusto von Dentz
Computer Engineer
