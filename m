Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4451F478.3070204@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: New HCI-USB device, no MAC?
References: <4410090A.3070706@kernelconcepts.de>	 <1141912311.4605.9.camel@aeonflux.holtmann.net>	 <44104DD5.80109@kernelconcepts.de>	 <1141923373.4605.39.camel@aeonflux.holtmann.net>	 <loom.20060412T215427-611@post.gmane.org>	 <444CAE4F.70404@kernelconcepts.de> <1145876694.21987.28.camel@localhost>
In-Reply-To: <1145876694.21987.28.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Fri, 28 Apr 2006 12:54:48 +0200

Hi!
In case anyone else is interested in this issue too, as I said I
contacted ISSC about missing MAC addresses and after some mail ping-pong
got the following response. They really seem to care about the issue
now. I just still wonder what will happen.

So, here come the emails, starting with the last reply from one of their
managers:


"Dear Nils:

Thank you very much for your comment. First of all, ISSC is the one of
important BT IC provider. We also provide one robust reference board design
solution for our system customers. This reference design had passed BQB
certification to our system customers for class 2 dongle. In the reference
design, BT Address will be saved in the on board EEPROM. It's the unique BT
address with legal IVT software without exception. For products shipped with
EEPROM, BT_Addr can be changed through HCI command. However, for dongles
shipped without EEPROM, there is no place to store the new BT_addr. Anyway,
ISSC also believe this is a very serious issue, and we have also contacted
Bluetooth SIG to ask for their advise of this specific problems.
Unfortunately, we have not receive any response from them yet. As stated in
our previous email response to you, ISSC "ALWAYS" ship our IC with a legal
IVT software without exceptions. Unfortunately, some manufacturers went for
the extreme to save manufacturing cost at the expense of BT quality. I'm
including this message to Mike Foley so that he is more aware of this
problem. ISSC will do whatever it takes to solve this problems. By the way,
it is because ISSC's products has a very large market share, hence you see
most problems with our products. I can assure you that this problem is not
ISSC isolated instance. It is a problem that we will like to resolve as much
as you do, if no more than you do. For, this will hurt our BT industry as a
whole more than anything else. Regarding to your recommandation, if we can
change the BT Address through the HCI interface. Because IVT software is the
only one software interface between the User and USB BT Dongle. ISSC will
discuss with IVT to check if any solution for it soon.

 Thank you very much for your understanding, and let's see if we can come
out with a solution to resolve this issue.

Sincerely yours,
I.S.S.C./Sales Division
2006/4/28"






----- Original Message -----
From: "ISSC Sales" <Sales@issc.com.tw>
To: "Nils Faerber" <nils.faerber@kernelconcepts.de>
Sent: Friday, April 28, 2006 10:36 AM
Subject: Re: Inquiry Form[BT Dongle issue]


> > Dear Sir:
> >
> > Very thank you for your kindly and useful reponds and suggestion.
> > We will pass your mail to our manager seriously.
> >
> > Thank you very much again!!
> >
> > Sincerely yours,
> > I.S.S.C./W
> > 2006/4/28
> >
> >
> >
> > ----- Original Message -----
> > From: "Nils Faerber" <nils.faerber@kernelconcepts.de>
> > To: "ISSC Sales" <Sales@issc.com.tw>
> > Sent: Thursday, April 27, 2006 6:58 PM
> > Subject: Re: Inquiry Form[BT Dongle issue]
> >
> >
>> > > ISSC Sales schrieb:
>>> > > > Dear Sir:
>> > > Hello!
>> > >
>> > > Thanks for your quick response!
>> > >
>>> > > > I.S.S.C. is a IC Vendor.
>>> > > > We offer BT IC with IVT sw together only.
>>> > > > We do not manufacture or sell any end product.
>> > >
>> > > Yes, I know.
>> > > But the described issue does not only occur with a specific
product but
>> > > with *most* ISSC based products.
>> > >
>>> > > > Therefor,Your bluetooth dongle is not I.S.S.C.'s product.
>>> > > > They just use I.S.S.C.'s chip and solution.
>> > >
>> > > Yes, correct.
>> > >
>>> > > > Your dongle should be NG product, please contact your original
>>> > > > seller/manufactur to solve end product issue for more
>>> > > > support.[ From the item "KY-BT100 ", here help you to find their
> > original
>>> > > > web-site
>>> > > >
> >
http://www.made-in-china.com/showroom/yagudo/product-list/catalog-1.html.
>>> > > > Hope it will be much helpful to you. Thank you very much!  ]
>> > >
>> > > Frankly, no, it was not helpful.
>> > >
>> > > You are the manufatcurer of the chipset and baseband software,
i.e. you
>> > > have the knowledge of the verdor specific HCI commands of your chips.
>> > > Most manufacturers will not deal with such details and just implement
>> > > your provided solution.
>> > >
>> > > But even if, I still think that it is your responsibility to get your
>> > > product based end user products right. ISSC is currently the only
>> > > chipset manufacturer with the problem of not providing correct
Bluetooth
>> > > addresses. So this must be also your problem not only the
integrator's.
>> > >
>> > > The only simple thing I am asking you for is the single simple HCI
>> > > command to set a correct Bluetooth MAC address.
>> > >
>> > > Please have a look on the market today and test-buy some products
that
>> > > implement your ISSC Bluetooth chipset. I would bet that more than
50% do
>> > > not carry a valid Bluetooth address which is a violation of the
>> > > Bluetooth specification.
>> > >
>> > > So please rethink your position and provide the HCI command or at
least
>> > > a ready made tool (e.g. for Windows-OS) to set the Bluetooth address.
>> > > Also please get in contact with your customers so that they pay
closer
>> > > attention to this issue! There are numerous reports about e.g.
Bluetooth
>> > > headsets that all have the same Bluetooth address (i.e.
>> > > 11:11:11:11:11:11). In such a situation it would be impossible to
have
>> > > more than one of those in the same piconet. An unacceptable
situation.
>> > > This has never been reported with chipsets e.g. from CSR.
>> > >
>>> > > > Sincerely yours,
>>> > > > I.S.S.C./W.
>>> > > > 2006/4/27
>> > > Best regards
>> > >   nils faerber
>> > >
>> > >
>>> > > > ----- Original Message -----
>>> > > > From: "Nils Faerber" <nils.faerber@kernelconcepts.de>
>>> > > > To: <sales@issc.com.tw>
>>> > > > Sent: Wednesday, April 26, 2006 5:35 PM
>>> > > > Subject: Inquiry Form
>>> > > >
>>> > > >
>>>> > > >> Interested in=Bluetooth Product
>>>> > > >> Solution=USB Dongle
>>>> > > >> Product=
>>>> > > >> Enquiry for=FAE
>>>> > > >> Company=kernel concepts
>>>> > > >> product=Operating software development
>>>> > > >> URL=http://www.kernelconcepts.de
>>>> > > >> Country=DE
>>>> > > >> Address=Dreisbachstr. 24, D-57250 Netphen
>>>> > > >> person=Nils Faerber
>>>> > > >> job=CTO
>>>> > > >> email=nils.faerber@kernelconcepts.de
>>>> > > >> Tel=+49-271-77109112
>>>> > > >> Fax=+49-271-77109119
>>>> > > >> Description=Dear ladies an gentlemen!
>>>> > > >> We are a software development company concentrated on Linux
kernel
and
>>>> > > >> system development. We are member of the Bluetooth SIG since
2000
> > (early
>>>> > > >> adopter) and have been part in the Linux Bluetooth stack
development
>>>> > > >> from the very early beginning.
>>>> > > >>
>>>> > > >> A customer of ours wants to deploy a device that uses your
Bluetooth
> > USB
>>>> > > >> chipset:
>>>> > > >>
>>>> > > >> ID 1131:1001 Integrated System Solution Corp. KY-BT100 Bluetooth
> > Adapter
>>>> > > >>
>>>> > > >> The problem we currently have with those devices is that
they do not
>>>> > > >> contain a valid Bluetooth MAC address, they come with a
default of
>>>> > > >> 11:11:11:11:11:11. We have seen this with all ISSC dongles.
We have
>>>> > > >> USB-HCI description for CSR based modules to change the MAC
address
to
> > a
>>>> > > >> correct value but not for your modules.
>>>> > > >>
>>>> > > >> So we would like to ask for your kind assistance! We just
need to
know
>>>> > > >> the HCI command to set the MAC (Bluetooth) address of thode
dongles.
>>>> > > >>
>>>> > > >> This would help us a lot and our customer can continue to
use your
fine
>>>> > > >> chips.
>>>> > > >>
>>>> > > >> Many thanks in advance for any information you can provide!
>>>> > > >>
>>>> > > >> Kind regards
>>>> > > >>   nils faerber
>>>> > > >>
>>>> > > >> PS: If we need to sign an NDA to get this information I
would gladly
do
>>> > > > so.
>>>> > > >> Result=Send
>>>> > > >>
>>>> > > >> --
>>>> > > >> kernel concepts          Tel: +49-271-771091-12
>>>> > > >> Dreisbachstr. 24         Fax: +49-271-771091-19
>>>> > > >> D-57250 Netphen          Mob: +49-176-21024535
>>>> > > >> --
>>>> > > >>
>>>> > > >>
>>> > > >
>> > >
>> > > --
>> > > kernel concepts          Tel: +49-271-771091-12
>> > > Dreisbachstr. 24         Fax: +49-271-771091-19
>> > > D-57250 Netphen          Mob: +49-176-21024535
>> > > --
>> > >
> >



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
