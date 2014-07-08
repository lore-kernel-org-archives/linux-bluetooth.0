Return-Path: <cyrus@holtmann.org>
Message-ID: <53BC3569.2060908@cs.stanford.edu>
Date: Tue, 08 Jul 2014 11:16:09 -0700
From: Amit Levy <levya@cs.stanford.edu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Connectin to an L2CAP channel over an LE
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm writing some code to benchmark various bluetooth low energy chips,
and am having issues connecting to an L2CAP channel. I'm able to pair
with the device with `hci_le_create_connection` (and on the device side
I can see the connection being established), however, I get some errors
I can't decypher when I try to `connect` to the ATT l2cap channel.

Piecing together from what gatttool and test/l2cap.c seem to do, I first
create a socket:

```
    int s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP);
    if (s < 0) {
      perror("socket");
      goto finish;
    }
```

then, I `bind` the socket to the ATT channel:

```
struct sockaddr_l2 bind_addr = { 0 };
bind_addr.l2_family = AF_BLUETOOTH;
bind_addr.l2_cid = htobs(4); // ATT CID
bacpy(&bind_addr.l2_bdaddr, BDADDR_ANY);
bind_addr.l2_bdaddr_type = BDADDR_LE_PUBLIC;

err = bind(s, (struct sockaddr*)&bind_addr, sizeof(bind_addr));
if (err) {
  perror("L2CAP bind");
  goto finish;
}
```

next, I set the socket options to make it an L2CAP_LM_MASTER and set
security to low. Finally, I try to connect:

```
struct sockaddr_l2 conn_addr = { 0 };
conn_addr.l2_family = AF_BLUETOOTH;
conn_addr.l2_cid = htobs(4); // ATT CID
bacpy(&conn_addr.l2_bdaddr, &dst_addr);
conn_addr.l2_bdaddr_type = dst_addr_type;

err = connect(s, (struct sockaddr*)&conn_addr, sizeof(conn_addr));
if (err) {
    perror("L2CAP connect");
    goto finish;
}
```

However, I always get an error EAGAIN (Device or resource busy), even
though I never set the socket to O_NONBLOCKING.

I'd really appreciate a pointer to either documentation or an example of
writing code to connect to an LE device.

Thanks!
Amit

