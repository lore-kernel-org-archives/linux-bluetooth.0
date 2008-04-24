Return-Path: <cyrus@holtmann.org>
Message-Id: <3096AE58-D58D-4DF3-81B2-07810FD16AA8@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1209052172510@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Thu, 24 Apr 2008 20:29:31 +0300
References: <2D804CC1-0304-47A8-B67F-00814B3BE516@gmail.com>
	<1209052172510@dmwebmail.dmwebmail.chezphil.org>
Subject: Re: [Bluez-users] Apple wireless keyboard
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

Hi Phil,

On Apr 24, 2008, at 18:49, Phil Endecott wrote:
>>> - Running hcitool scan to get the keyboard address (which I've now
>>> written on the back)
>>> - Running hidd --connect <addr> and typing 1234RET on the keyboard
>>
>> Both of these are fine but instead of using hidd you'd use the  
>> Connect
>> method that the input service provides (I think there's an example of
>> that too in the wiki).
>
> Hmm.  So rather than running "hcitool scan" and "hidd --conect  
> <addr>",
> I have to write a few lines of python (a language I've never used) to
> communicate over dbus (a protocol that I've never used) to this "input
> service" thing?  If that's the case, then I can't say this looks like
> an improvement in usability.

If you take a look at the wiki page you'll see that this can be  
accomplished with a couple of dbus-send commands which isn't that  
different from using hcitool and hidd (though the parameter list to  
dbus-send is certainly longer compared to the legacy commands). On the  
other hand, this D-Bus interface is of course something that an end  
user should never see. Instead, his environment of choice (be it  
GNOME, KDE, or something else) should provide a proper UI to do all  
this, and a D-Bus interface is a much cleaner solution compared to  
e.g. a GUI calling the legacy command line tools whose parameter lists  
and outputs have never been defined as a stable API.

What is a valid criticism of the current situation though is that  
compared to the legacy command line tools there doesn't exist as  
simple (or simpler) counterparts for the D-Bus API. This is mostly  
because using dbus-send or hacking together a quick python scrip  
hasn't been that big of a trouble for developers. However, while it is  
the responsibility of the different GUI environments to provide a  
proper GUI for using BlueZ (accessing it's D-Bus API) I do agree that  
BlueZ should continue providing easy to use command line tools for the  
D-Bus API's and hopefully there will be improvement in this area in  
the future.

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
