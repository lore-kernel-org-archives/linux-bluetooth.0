Return-Path: <cyrus@holtmann.org>
Message-Id: <2A1E7937-4DA2-4B00-8EBD-10DC50269D54@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e378cfb20807170101iec7c9e5jfeb3aa1afe9e01e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Date: Thu, 17 Jul 2008 11:06:16 +0300
References: <e96e9eeb0807160834n6eb74e3dn133d7abfb333d07b@mail.gmail.com>
	<e378cfb20807170101iec7c9e5jfeb3aa1afe9e01e@mail.gmail.com>
Subject: Re: [Bluez-users] bluez-utils 3.36: Unable to get on D-Bus
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

Hi,

On Jul 17, 2008, at 11:01, Nel D wrote:
> On Wed, Jul 16, 2008 at 9:04 PM, Voni Hakau <hakauvoni@gmail.com>  
> wrote:
>>
>> I get the following error:
>>
>> # hcid -n -s -d
>> hcid[467]: Bluetooth HCI daemon
>> hcid[467]: Enabling debug information
>> hcid[467]: Unable to get on D-Bus
>
> Try starting hcid as root. Also check if another instance of "hcid" is
> already running when u issue this command??

Another common cause of this error is that the user hasn't installed  
the D-Bus policy configuration for BlueZ into /etc/dbus-1/system.d  
(the hcid/bluetooth.conf file).

Johan

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
