Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 20 Sep 2007 15:26:50 +0200
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070920132650.GA18583@suse.de>
References: <46F19B7F.70702@ozob.net>
MIME-Version: 1.0
In-Reply-To: <46F19B7F.70702@ozob.net>
Subject: Re: [Bluez-users] How do I get rfcomm to reread config file?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, Sep 19, 2007 at 04:58:23PM -0500, Gene Imes wrote:
> I am posting again because my first post did not get a reply.
> =

> I have several bluetooth gps receivers. In /etc/bluetooth/rfcomm.conf I =

> have their MAC address listed but commented out except the one I want to =

> use. However, when change and restart the bluetooth service the new =

> address is not picked up and the old one is still by rfcomm.
> =

> How can I get rfcomm to pick up the new MAC?

rfcomm release all
rfcomm bind all

is one way to do it.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
