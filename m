Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jun 2011 02:22:07 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Tomas Targownik <ttargownik@geicp.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Memory leak on failed connection attempt
Message-ID: <20110630052207.GB3438@joana>
References: <1306997293.1926.83.camel@rnd3>
 <20110602135720.GB2790@joana>
 <1308035004.1926.611.camel@rnd3>
 <1308180155.1926.640.camel@rnd3>
 <20110616212645.GF2594@joana>
 <1308868481.2042.58.camel@rnd3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308868481.2042.58.camel@rnd3>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

* Tomas Targownik <ttargownik@geicp.com> [2011-06-24 08:34:41 +1000]:

> I have isolated the memory leak to the hci_conn struct not being freed
> on a hci_conn_del() call if the remote bluetooth device is not present.
> The patch below remedies this.
> 
> ---
> net/bluetooth/hci_conn.c |    5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 7a6f56b..62510f7 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -375,6 +375,11 @@ int hci_conn_del(struct hci_conn *conn)
> 
> hci_dev_put(hdev);
> 
> +   if (conn->handle == 0)
> +   {
> +       kfree(conn);
> +   }
> +
> return 0;

I agree with this patch, but just send me a git formatted patch with proper
coding style.

	Gustavo
