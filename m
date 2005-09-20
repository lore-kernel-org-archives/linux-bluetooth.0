Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Stephen Crane <jscrane@maths.tcd.ie>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] How inquiry to a custo IAC code ?
Message-ID: <20050920151320.GA30870@salmon.maths.tcd.ie>
References: <becc9d2c0509200605212255a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <becc9d2c0509200605212255a9@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 20 Sep 2005 16:13:20 +0100

On Tue, Sep 20, 2005 at 03:05:29PM +0200, Andrea Carlevato wrote:
> Hello,
> i ve set a bluetooth dongle to a custom iac code via:
> "hciconfig hci0 iac 0x9e8b17"
> ,and correctly it is not detected anymore by standard inquiry.
> 
> My question is: how can i ask another dongle to inquiry to that iac ?
> I ve tried setting this dongle with the same "hciconfig hci0 iac 0x9e8b17"
> but it still inquiries to the standard IAC.

Hmmm, interesting. I would have thought this would be a parameter to
hcitool inq but it doesn't seem to support that. (Send in a patch: all
you need to do is pass the IAC value as the lap parameter to hci_inquiry().)

Steve


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
