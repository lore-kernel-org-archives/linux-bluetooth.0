Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Oct 2009 16:38:46 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Valmantas =?iso-8859-15?Q?Palik=A8a?= <walmis@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Corruption in bluetoothd if started when adapter was rfkilled
Message-ID: <20091020133610.GA14042@jh-x301>
References: <1255696908.12027.15.camel@walmis-laptop>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SWTRyWv/ijrBap1m"
In-Reply-To: <1255696908.12027.15.camel@walmis-laptop>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

On Fri, Oct 16, 2009, Valmantas Palik¨a wrote:
> Steps to reproduce:
> 1. rfkill block bluetooth
> 2. start bluetoothd
> 3. kill bluetoothd

I don't seem to have rfkill support (at least using that command) on my
laptop so I can't verify this fix, but could you try the attached patch
and see if it resolves the issue? The problem seems to be that in this use
case we never load/probe the adapter drivers but still call their remove
callbacks when the adapter initialization fails. This causes some drivers
to call btd_adapter_unref on adapter objects for which they do not own a
reference.

Johan

--SWTRyWv/ijrBap1m
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="adapter-init.patch"

diff --git a/src/adapter.c b/src/adapter.c
index ab07ca7..d225b86 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2472,7 +2472,8 @@ void adapter_remove(struct btd_adapter *adapter)
 		device_remove(l->data, FALSE);
 	g_slist_free(adapter->devices);
 
-	unload_drivers(adapter);
+	if (adapter->initialized)
+		unload_drivers(adapter);
 
 	/* Return adapter to down state if it was not up on init */
 	if (adapter->up && !adapter->already_up)

--SWTRyWv/ijrBap1m--
