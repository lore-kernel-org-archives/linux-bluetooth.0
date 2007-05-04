Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "=?ISO-8859-2?Q?Tomasz_Chili=F1ski?=" <tomasz.chilinski@chilan.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Fri, 4 May 2007 16:12:57 +0200
Message-Id: <20070504141123.M13137@chilan.com>
In-Reply-To: <463B3D17.50307@xmission.com>
References: <20070503214340.M20676@chilan.com>	<1178260119.25425.12.camel@violet>
	<20070504084720.M21573@chilan.com> <463B3D17.50307@xmission.com>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] kernel 2.6.21 btsco 0.50 patch
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

On Fri, 04 May 2007 08:03:03 -0600, Brad Midgley wrote
> Tomasz

Brad

> > There are minor problems with btsco kernel module with linux versions
> > above 2.6.20.x, for now with 2.6.21.x.
> > The attachment is a solution for all problems.
> > PS. I have also made diff with typedefs taken from kernel <=2.6.20.x,
> > but I think we should avoid include files dependencies...
> 
> this should still build and work with older kernels, right?

Yes.

> brad

Tomasz.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
