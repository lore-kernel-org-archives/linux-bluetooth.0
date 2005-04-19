Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth audio support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050419204937.50772.qmail@web54704.mail.yahoo.com>
References: <20050419204937.50772.qmail@web54704.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1113944126.2469.68.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 19 Apr 2005 22:55:26 +0200

Hi Hiren,

> i have downloaded & installed the pskey utility. however when i do a 
> 
> pskey -d /dev/ttySB0, it gives me an error. the exact message is like
> this
> 
>  
> 
> $ pskey -d /dev/ttySB0
> 
> Physical device: /dev/ttSB0
> 
> Speed          : 115200
> 
> Use BCSP       : NO
> 
> Initiating read thread
> 
> Now trying to read firmware info
> 
> Timeout!!!
> 
> Error in reading firmware info
> 
>  
> 
> Can any1 guide why this error? Also if any1 could direct me to a
> 'pskey' manual. I couldn't find it online anywhere. for those of you
> don't recollect i'm trying to get bluetooth audio working (via SCO) on
> my ipaq 3870 with Familiar Linux v0.8.1

the iPAQ is using BCSP as transport protocol and I think you must tell
this to pskey. Maybe the parameter is "-b" or "-B".

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
