Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: hugues <Hugues.Lafarge@afp.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <200607271240.49400.fexpop@onlinehome.de><200607281128.09414.fexpop@onlinehome.de><1154079513.2298.20.camel@localhost><200607281203.27951.fexpop@onlinehome.de><1154081170.2298.26.camel@localhost>
Date: Fri, 28 Jul 2006 12:40:18 +0200
In-Reply-To: <1154081170.2298.26.camel@localhost> (Marcel Holtmann's messageof
	"Fri, 28 Jul 2006 12:06:10 +0200")
Message-ID: <874px26mi5.fsf@merlot.par.afp.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
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

>>>>> "Marcel" == Marcel Holtmann <marcel@holtmann.org> writes:

    Marcel> Hi Felix,
    >> > the dbus-test is a Python script. Simple checkout the CVS and use this
    >> > one. You need to modify DiscoverableTimeout and Mode. No need to update
    >> > the whole BlueZ packages.
    >> 
    >> Here's what I get:
    >> 
    >> #./dbus-test
    >> File "./dbus-test", line 178
    >> @dbus.decorators.explicitly_pass_message
    >> ^
    >> SyntaxError: invalid syntax

    Marcel> no idea what's wrong here. I am not a Python expert.

Not an expert either, but i might have a clue:

$ python2.3 ./dbus-test

  File "./dbus-test", line 178
    @dbus.decorators.explicitly_pass_message
    ^
SyntaxError: invalid syntax

$ python2.4 ./dbus-test

Usage: ./dbus-test [-i <dev>] [-l] [-h] <cmd> [arg1..]
  -i <dev>   Specify device (e.g. "hci0" or "/org/bluez/hci0")
  -l         Listen for events (no command required)
  -h         Show this help
Manager commands:
	InterfaceVersion
	ListAdapters
	DefaultAdapter
Adapter commands:
	GetAddress
	GetVersion
	GetRevision
	GetManufacturer
	GetCompany
	GetMode
	SetMode
	GetDiscoverableTimeout
	SetDiscoverableTimeout
	IsConnectable
	IsDiscoverable
	IsConnected
	ListConnections
	GetMajorClass
	ListAvailableMinorClasses
	GetMinorClass
	SetMinorClass
	GetServiceClasses
	GetName
	SetName
	GetRemoteVersion
	GetRemoteRevision
	GetRemoteManufacturer
	GetRemoteCompany
	GetRemoteName
	GetRemoteMajorClass
	GetRemoteMinorClass
	GetRemoteServiceClasses
	GetRemoteAlias
	SetRemoteAlias
	ClearRemoteAlias
	LastSeen
	LastUsed
	DisconnectRemoteDevice
	CreateBonding
	CancelBondingProcess
	RemoveBonding
	HasBonding
	ListBondings
	GetPinCodeLength
	GetEncryptionKeySize
	DiscoverDevices
	DiscoverDevicesWithoutNameResolving
	CancelDiscovery

So maybe python version should be at least 2.4 ?!

    >> BTW, if I could change settings via dbus-test would they be remembered the 
    >> next time I plug the dongle in?

    Marcel> Yes. All changes over the D-Bus API will be remembered. This is also
    Marcel> includes the device name and the class of device.

    >> Furthermore, if iscan/pscan options in hcid.conf are not working as before it 
    >> shoud be mentioned somewhere in the documentation.

    Marcel> This stuff will all go away. It is part of the cleanup process.

    Marcel> Regards

    Marcel> Marcel



    Marcel> -------------------------------------------------------------------------
    Marcel> Take Surveys. Earn Cash. Influence the Future of IT
    Marcel> Join SourceForge.net's Techsay panel and you'll get the chance to share your
    Marcel> opinions on IT & business topics through brief surveys -- and earn cash
    Marcel> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
    Marcel> _______________________________________________
    Marcel> Bluez-users mailing list
    Marcel> Bluez-users@lists.sourceforge.net
    Marcel> https://lists.sourceforge.net/lists/listinfo/bluez-users


-- 
Hugues Lafarge                    || Email: Hugues.Lafarge@afp.com
Agence France Presse              || Phone: +33 1 40 41 77 15
4 rue de la bourse, 75002 Paris   ||   Fax: +33 1 40 41 79 24
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

This e-mail, and any file transmitted with it, is confidential and  intended solely for the use of the individual or entity to whom it is addressed. If you have received this email in error, please  contact the sender and delete the email from your system. If you are  not the named addressee you should not disseminate, distribute or copy  this email.

For more information on Agence France-Presse, please visit our web site at http://www.afp.com

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
