Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Przemek <aquamala@o2.pl>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2test: Send failed. Invalid argument(22)
Message-ID: <20040506221323.GA3838@reynevan>
Reply-To: aquamala@o2.pl
References: <20040506204859.GA2483@reynevan> <1083877861.4420.84.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <1083877861.4420.84.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 7 May 2004 00:13:23 +0200

On 06/05, Marcel Holtmann wrote:
> From a quick view it looks like your
> data is bigger than your MTU. L2CAP is sequential packet and not a
> stream.

That's right! I should have used -b option with l2test.
Thank you vary much!

Best regards, 
Przemek


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
