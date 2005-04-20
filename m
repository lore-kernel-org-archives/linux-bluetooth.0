Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4265F784.5060405@metalan.net>
From: Andre Baron <andre@metalan.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple BT Keyboard and Ubuntu Linux
References: <42649E3C.1080608@metalan.net>	 <1113907413.16233.167.camel@pegasus>  <42654471.7090804@metalan.net>	 <1113934141.2469.53.camel@pegasus>  <42655077.7080609@metalan.net>	 <1113936350.2469.56.camel@pegasus>  <4265543A.2000505@metalan.net> <1113937497.2469.59.camel@pegasus>
In-Reply-To: <1113937497.2469.59.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 19 Apr 2005 23:32:36 -0700

Marcel Holtmann wrote:

>Hi Andre,
>  
>
>now you have to fix this problem above. The hcid is not getting the
>correct PIN code from the PIN helper program. Check the mailing list
>archive for a solution or workaround for this problem.
>
>Regards
>
>Marcel
>
>  
>
Thanks Marcel,

I got it working, turns out when I updated the bluez utils it overwrote 
my old hcid.conf file, and disregarded the pin help program specified. 
The one it put in it's place (bluepin) doesn't work, for whatever reason 
(probably missing components to display it on my system). Whe I changed 
it to bluez-pin it prmpted me just like it was sopposed to. Everything 
is working great now.

Andre
--This email written on an Apple BT Keboard!


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
