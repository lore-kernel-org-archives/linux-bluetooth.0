Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 23 Jun 2006 22:56:46 +0200
From: =?windows-1252?Q?G=F6tz_Issel?= <g.issel@fh-wolfenbuettel.de>
To: bluez-devel@lists.sourceforge.net
Message-id: <17c121177c91.177c9117c121@fh-wolfenbuettel.de>
MIME-version: 1.0
Subject: Re: [Bluez-devel] blueZ and SAP
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

Hi Mayank,
> 
> On 6/21/06, Mayank Batra <mayankbatra@gmail.com> wrote:
> >
> >  *But tell me one thing: After you receive a connect_resp from 
> the phone,
> > do you receive a status_ind as well?*
> > *This is important, because if you do not receive this, the 
> connection is
> > not really up. See page 22 of the spec.*
> >
> So, I mean that after you've read the connect_resp, you should perform
> another read for the status_ind which will be something like:
> 
> 0x11 0x01 0x00 0x00 0x08 0x00 0x00 0x01 0x04 0x00 0x00 0x00
> 
> 0x11 is msg_id for status_ind.
> 0x08 is parameter_id for StatusChange
> 0x04 is the value of StatusChange which says "Card Inserted"
> > 
> Please let me know in case you want any further information.

Well, all seems to be fine now, I got the connect_req and response, get
the following status_ind (saying 'card reset' which is correct) and I
implemented a few more messages by now already, ie requesting the card
reader status etc. I hope to finish all SAP messages by Monday so I can
hook up my gsm modem (which does support SAP) and see how that responds.
I do already have the multiplexing on serial port (specified in GSM
standard somewhere) working for it. Wish me luck to have all interact in
a way expected.
Thanks for the offer to help, I will see if I have more questions or not.
Greetings,
Goetz


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
