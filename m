Return-Path: <cyrus@holtmann.org>
Message-ID: <20110628103424.4427602n9v0xrhc0@mail.hendrik-sattler.de>
Date: Tue, 28 Jun 2011 10:34:24 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: openobex-users@lists.sourceforge.net, Nami <nami.li@atheros.com>
References: <1309247272-11329-1-git-send-email-nami.li@atheros.com>
In-Reply-To: <1309247272-11329-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [openobex-users] [PATCH v3 openobex 1/3] Add transport format
 member in fdobex_data struct. Support STREAM and SEQPACKET transport
 format.
Reply-To: openobex-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openobex-users>,
	<mailto:openobex-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openobex-users>
List-Post: <mailto:openobex-users@lists.sourceforge.net>
List-Help: <mailto:openobex-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openobex-users>,
	<mailto:openobex-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Errors-To: openobex-users-bounces@lists.sourceforge.net
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Nami <nami.li@atheros.com>:

> These patches enable fd obex transport to support SEQPACKET format  
> to read entire packet at a time.
> Add fmt member to indicate transport format, the init value is STREAM format.
> Create a new api for upper layer to set transport format when using  
> OBEX over L2CAP.

All 3 patches look ok to me. So even if it is not needed for L2CAP on  
bluez, it is a useful addition for FdOBEX.

@Johan: please submit them to the openobex tree.

HS




------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Openobex-users mailing list
Openobex-users@lists.sourceforge.net
http://lists.sourceforge.net/lists/listinfo/openobex-users
