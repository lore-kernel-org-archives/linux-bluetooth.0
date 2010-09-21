Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTikwvCiCLj4Hvr=zSQHOm33e059z2W6MA0T5C2ZO@mail.gmail.com>
References: <7866937.1285030222002.JavaMail.root@elwamui-darkeyed.atl.sa.earthlink.net>
	<AANLkTi=hD_U-19oPnQzQemt5wBgAqip3h7esJZpgkr4e@mail.gmail.com>
	<AANLkTi=gRJgyFD2uC-UsjzjQCU11326SSsN4+nsTxk9-@mail.gmail.com>
	<AANLkTikwvCiCLj4Hvr=zSQHOm33e059z2W6MA0T5C2ZO@mail.gmail.com>
Date: Tue, 21 Sep 2010 23:46:10 +0530
Message-ID: <AANLkTimf-VQuF3DuGxA8TmEVDE27nyXSQoHTGU0cGxTO@mail.gmail.com>
Subject: Re: Need complete docs on PAN and DUN with bluez 4.66
From: Arun Kumar <arunkat@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mumia W <mumia.w.18.spam@earthlink.net>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Hi,
>
> On Tue, Sep 21, 2010 at 6:56 AM, Arun Kumar <arunkat@gmail.com> wrote:
>> Depends on what role you want to use pand for ...pand is launched as a
>> daemon via command line with set of options you may want to use it for
>> your requirements ...
>
> I wouldn't suggest using pand nor dund because they are deprecated.

I understand that dun and its apis are deprecated from bluez but not
sure on pan. I guess its api's are still exported on dbus as network
api's- unless there are plans to deprecate it too in near future...

> PAN is really dead simple, Network.Connect() returns the network
> interface in case of success

isnt it what Network.Connect() is supposed to return?

>and both NetworkManager and connman
> should be able to use them, in fact I think both already have specif
> PAN support to connect from their ui.

Well its entirely upto to the use-case & sub-system above d-bus on how
to use network api's and implement pan. In case of Meego and ui based
PAN use case, it may be true, but there are still platforms and
subsystems that use vanilla pand to setup pan as GN/nap etc via a
daemon process.

> Both Network and Serial interface are documented in doc/ diretory,
> there is also test-network and test-serial under test/ that can be
> used to manually connect to those profiles.

True. Alternatively if the use case is to simply set up the device in
nap role with bluez, for instance,
pand -s -r NAP  -M -n could well be used. It would set up the device
in NAP role after auto registering same with SDP.


> Luiz Augusto von Dentz
> Computer Engineer
>

Best Regards,
Arun Kumar Singh
www.crazydaks.com
