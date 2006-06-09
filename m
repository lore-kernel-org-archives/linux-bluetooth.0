Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <CA21EAA4DF189C40A3BC30A5A75DA56002551241@ratatosk>
References: <CA21EAA4DF189C40A3BC30A5A75DA56002551241@ratatosk>
Date: Fri, 09 Jun 2006 09:53:05 +0200
Message-Id: <1149839585.6618.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Changing default paths in hcid?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Birger,

> I've cross compiled BlueZ libs and utils for an arm based platform and most things work nice. However, when running hcid it assumes to find things at a path that I defined as install path at the host system (i.e. set by the PREFIX flag). 
> 
> I did this since I do not want to install the cross compiled things on my host. 
> 
> I configured with:
> ./configure --prefix=[mypath] --host=arm-linux
> 
> Does anyone know the correct way of cross compiling and install bluez on a target system I would appreciate some hints.

do the install with "make install DESTDIR=$PWD/tmp" and then pack up the
tmp/ directory.

Regards

Marcel




_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
