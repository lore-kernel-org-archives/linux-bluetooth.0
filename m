Return-Path: <cyrus@holtmann.org>
Subject: Re: Memory leak on failed connection attempt
From: Tomas Targownik <ttargownik@geicp.com>
Reply-To: ttargownik@geicp.com
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20110616212645.GF2594@joana>
References: <1306997293.1926.83.camel@rnd3> <20110602135720.GB2790@joana>
	 <1308035004.1926.611.camel@rnd3> <1308180155.1926.640.camel@rnd3>
	 <20110616212645.GF2594@joana>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Jun 2011 08:34:41 +1000
Message-ID: <1308868481.2042.58.camel@rnd3>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have isolated the memory leak to the hci_conn struct not being freed
on a hci_conn_del() call if the remote bluetooth device is not present.
The patch below remedies this.

---
net/bluetooth/hci_conn.c |    5 +++++
1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7a6f56b..62510f7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -375,6 +375,11 @@ int hci_conn_del(struct hci_conn *conn)

hci_dev_put(hdev);

+   if (conn->handle == 0)
+   {
+       kfree(conn);
+   }
+
return 0;
}


Best regards, 
Tomas Targownik

