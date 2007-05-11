Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <464338E7.9080902@access-company.com>
References: <4642D045.60007@access-company.com>
	<1178789626.25565.71.camel@aeonflux.holtmann.net>
	<4642E92C.6030604@access-company.com>
	<1178791415.25565.83.camel@aeonflux.holtmann.net>
	<464338E7.9080902@access-company.com>
Date: Fri, 11 May 2007 10:24:00 +0200
Message-Id: <1178871840.2820.6.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] non persistent sdp records
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

Hi Frederic,

> > actually using the standalone is a race condition. You should really
> > consider switching to hcid -s. It also saves you some memory footprint.
> >   
> Well, I'm lazy, I would like not to rewrite code...

actually for this you don't have to rewrite anything. Simply use
--disable-sdpd and then then call hcid -s on startup. That gives you the
same SDP API as before. Except you have one daemon less to start and you
no longer have race-conditions between hcid and sdpd.

> >> We will probably consider dbus as is sounds much easier, but it is 
> >> important to be able to do as much as what can be done through sdp api.
> >>     
> > Why?
> >   
> I wasn't clear, I meant having no regression in regards to what we 
> actually use, doing exactly the same sdp records we have in pand, a2dpd, ...

Since pand and sdpd will be removed at some point (don't worry, they
will be around for quite some time), you might seriously consider the
D-Bus API.

Anyhow, I think you found a real bug and might wanna fix the persistent
versus non-persistent SDP record creation.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
