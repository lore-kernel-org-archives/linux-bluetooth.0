Return-Path: <cyrus@holtmann.org>
Message-ID: <486E993B.6060702@earthlink.net>
Date: Fri, 04 Jul 2008 16:42:19 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <g4m2nu$j88$1@ger.gmane.org>
In-Reply-To: <g4m2nu$j88$1@ger.gmane.org>
Subject: Re: [Bluez-users] Override default inquiry mode?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 07/04/2008 03:55 PM, Norbert Unterberg wrote:
> Hi,
> 
> I have got one of those tiny bluetooth USB adapters
> (http://www.anycom.com/products/bluetooth_it_pc_accessoires/?id=102&group_id=3,
> Broadcom chipset) and want to use it on my EEE PC. However, it does not work as
> I hoped.
> 
> The adapter only works after setting the inquiry mode from RSSI/Extended to
> standard mode using
> hciconfig hcio reset
> hciconfig hci0 inqmode 0
> 
> Is there any way to tell the bluetooth stack (i.e. in one of its config files)
> to always use the standard mode for this adapter, or even for all adapters?
> 
> Norbert
> 

I have remarkably little knowledge of Bluetooth, and I haven't had any 
experience with the EeePC, but I suspect that you could create a startup 
script that performs those "hciconfig" actions.



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
