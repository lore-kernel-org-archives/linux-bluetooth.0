Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 29 Dec 2006 01:10:29 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20061228230903.GA3190@localhost.localdomain>
References: <4593C480.5080806@nokia.com>
MIME-Version: 1.0
In-Reply-To: <4593C480.5080806@nokia.com>
Subject: Re: [Bluez-devel] [PATCH] New RemoteDeviceDisconnectionRequested
	signal implementation
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Luca,

On Thu, Dec 28, 2006, Luciano Coelho wrote:
> As agreed last week, I've implemented a new D-Bus signal in hcid that 
> allows upper-level applications to disconnect gracefuly before the ACL 
> connection is terminated as a result of a call to RemoteDeviceDisconnect.
> 
> So, this is how it works: when the RemoteDeviceDisconnect is called, we 
> send the new signal RemoteDeviceDisconnectionRequested(string bdaddr) 
> and wait for 2 seconds before sending the disconnection command to the 
> controller.  This enables the service implementations to disconnect in a 
> nicer way, as specified in the profile specs (eg. in SIM Access Profile, 
> a SIM_DISCONNECT_REQ can be sent by the client).
> 
> The change is not very big and should be backwards compatible, except 
> for the fact that disconnections will take 2 seconds longer than before.
> 
> I also updated the documentation and the apitest script.
> 
> Please let me know what you think.

Looks good to me.

Johan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
