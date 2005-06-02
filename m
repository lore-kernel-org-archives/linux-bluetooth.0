Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "Christopher J. Bottaro" <cjbottaro@alumni.cs.utexas.edu>
Message-ID: <d7ntaf$gdl$1@sea.gmane.org>
References: <d7nnk4$7n4$1@sea.gmane.org> <1117744047.13834.21.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: newbie: automatic pairing with a mouse
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
Date: Thu, 02 Jun 2005 16:25:58 -0500

<posted & mailed>

Marcel Holtmann wrote:

> Hi Christoper,
> 
>> I have a laptop with internal bluetooth and an IOGear bluetooth mouse. 
>> The mouse pairs and works fine after I issue 'hidd --search', but if I
>> reboot my computer, I have to issue that command again for the mouse to
>> be paired
>> again.  Also, if I don't use my mouse for a few mins, it will de-pair and
>> I have to issue another 'hidd --search' to get it working again.
>> 
>> My question is how do I get my computer to automatically pair with the
>> mouse everytime the mouse is near it and turned on?
>> 
>> I am using Fedora Core 3, if that matters.
>> 
>> I have read a few posts about this, but I'm very newb to this whole
>> bluetooth thing.  Here is what I've tried so far:
>> 
>> 1) echo "HIDD_ENABLED=1\nHIDD_OPTIONS="--server" >
>> /etc/default/bluez-utils
>> 2) turning on authentication and encryption in hcid.conf.  This produced
>> a link_key file after pairing, but didn't alleviate my problem.
> 
> you must make sure that "hidd --server" is running as root to accept
> re-connections. I don't know how the Fedore Core init scripts are
> designed, but in general they should support it.

Thank you very much, that did it.  For anyone running Fedora Core, here are
the steps I took:
1)  echo HIDDARGS=\"--server\" > /etc/sysconfig/hidd
2)  chkconfig --level 35 hidd on

-- C
 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
