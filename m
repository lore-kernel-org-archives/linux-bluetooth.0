Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Jan 2008 00:09:10 +0100
From: Pavel Semerad <semerad@sisal.mff.cuni.cz>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20080107230910.GA5883@ps.ms.mff.cuni.cz>
MIME-Version: 1.0
Subject: [Bluez-devel] patch removing one extra memset
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


Helo,

I have found one mistake in audio/ctl_bluetooth.c . When initializing
this plugin, 'data' is allocated and memset-ed to 0. Then socket is
created and assigned to 'data'. And then there is another memset, which
sets this socket back to zero.
    Patch removing this extra memset is attached:

--- ./audio/ctl_bluetooth.c.ps  2007-12-08 20:04:39.000000000 +0100
+++ ./audio/ctl_bluetooth.c     2008-01-07 23:41:23.000000000 +0100
@ -327,8 +327,6 @@ SND_CTL_PLUGIN_DEFINE_FUNC(bluetooth)
        if (err < 0)
                goto error;
 
-       memset(data, 0, sizeof(*data));
-
        data->ext.version = SND_CTL_EXT_VERSION;
        data->ext.card_idx = -1;
 

Pavel Semerad


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
