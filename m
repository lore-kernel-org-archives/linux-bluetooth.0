Return-Path: <cyrus@holtmann.org>
Subject: Re: bluetooth-agent
From: =?ISO-8859-1?Q?Germ=E1n?= Pedrosa
	<german.pedrosa@fundacionctic.org>
To: alok barsode <alokbarsode@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <8b5debfa0910290555h7dd21bb5g5cdf481bda2212d9@mail.gmail.com>
References: <1256730946.6820.14.camel@german-desktop>
	 <f9d4bd30910280621u2f2102afq4d363b5722ff285@mail.gmail.com>
	 <1256740999.6820.23.camel@german-desktop>
	 <4CAA0D07-C612-4AA6-A5D8-1143F8B252AF@gmail.com>
	 <1256743414.6820.33.camel@german-desktop>
	 <8b5debfa0910280837g7f40ef98i31a46982d3f78793@mail.gmail.com>
	 <1256820460.4369.2.camel@german-desktop>
	 <8b5debfa0910290555h7dd21bb5g5cdf481bda2212d9@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Oct 2009 14:09:59 +0100
Message-Id: <1256821799.4369.7.camel@german-desktop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

In your last mail, you said:
>> Can you register an agent per adapter ? just run ./adapter --agent
> >> "hciX" 0000 for every 'X' adapter.
I didn't find the adapter program (I know, I've just seen that it is a mistake, it is the agent program), so I decided to modify the Python script.

This solution should be better, I'll try it.

Thanks a lot.

El jue, 29-10-2009 a las 18:25 +0530, alok barsode escribió:
> Hi German,
> 
> On Thu, Oct 29, 2009 at 6:17 PM, Germán Pedrosa
> <german.pedrosa@fundacionctic.org> wrote:
> > Hi Alok,
> >
> > Finally I decided to modify the python script, in order to add the
> > PinCode as a parameter.
> 
> Why did u have to modify it? it prompts you for one during
> authentication. If u want to hardcode it, use test/agent  program
> instead.
> >
> > Thank you very much.
> >
> 
> Cheers,
> Alok.
> > El mié, 28-10-2009 a las 21:07 +0530, alok barsode escribió:
> >> Hi German,
> >>
> >> On Wed, Oct 28, 2009 at 8:53 PM, Germán Pedrosa
> >> <german.pedrosa@fundacionctic.org> wrote:
> >> > I agree with your point that use JNI would be better than run shell
> >> > commands from Java code.
> >> >
> >> > But here the scenario is totally different: in our architecture the Java
> >> > components are not in charge to run such a kind of things; there are a
> >> > set on bash scripts that run some previous deendencies of our system,
> >> > such as bluetoth-agent.
> >>
> >> Are you refering to  /test/agent program ?
> >>
> >> Can you register an agent per adapter ? just run ./adapter --agent
> >> "hciX" 0000 for every 'X' adapter.
> >>
> >> Or you can use the python script simple-agent for every adapter  by
> >> running ./simple-agent hciX
> >>
> >> Hope this helps.
> >>
> >> Cheers,
> >> Alok.
> >>
> >> >
> >> > Therefore I'd need to replicate the behaviour explained by Claudio
> >> > before in this thread, but instead of calling the native api, invoking
> >> > the command line tool.
> >> >
> >> > Best regards,
> >> >
> >> > El mié, 28-10-2009 a las 09:09 -0600, LORENZO ANTONIO BRITO MORALES
> >> > escribió:
> >> >> im very shure, but the library from java dont support a lot of
> >> >> commands...
> >> >> Im developing a system based in bluez , i think is better to code
> >> >> somethings in c, then use
> >> >> JINI to use C in java.. i think it will be easier for you doing in
> >> >> this way, than using a command line from java.
> >> >
> >> >> On 28/10/2009, at 08:43 a.m., Germán Pedrosa wrote:
> >> >>
> >> >> > Dear Claudio,
> >> >> >
> >> >> > thanks for your quick answer.
> >> >> >
> >> >> > But I'm not using BlueZ's API from a C program. We're using Java, so
> >> >> > I'd
> >> >> > like to run bluetooh-agent directly from the shell. Is there any way
> >> >> > to
> >> >> > handle requests for all dongles using the command line tool?
> >> >> >
> >> >> > I tried using --path, but I didn't get any result. Probably because
> >> >> > I'm
> >> >> > not sure how the mapping between bluetooth and unix devices work.
> >> >> >
> >> >> > Thanks in advance.
> >> >> >
> >> >> > Best,
> >> >> >
> >> >> >
> >> >> > El mié, 28-10-2009 a las 11:21 -0200, Claudio Takahasi escribió:
> >> >> >>
> >> >> >> Hi German,
> >> >> >>
> >> >> >> you can register the same bluetooth-agent to handle requests for
> >> >> >> all dongles.
> >> >> >>
> >> >> >> See simple-agent code under test directory, there is an example how
> >> >> >> to
> >> >> >> register agent.
> >> >> >> Basically you need to call:
> >> >> >> adapter0.RegisterAgent(path, "DisplayYesNo")
> >> >> >> adapter1.RegisterAgent(path, "DisplayYesNo")
> >> >> >> ...
> >> >> >>
> >> >> >> There isn't man pages for bluetooth-agent, see agent-api.txt under
> >> >> >> doc
> >> >> >> directory.
> >> >> >>
> >> >> >> Cheers,
> >> >> >> krau
> >> >> >
> >> >> > On Wed, Oct 28, 2009 at 9:55 AM, Germán Pedrosa
> >> >> >> <german.pedrosa@fundacionctic.org> wrote:
> >> >> >>> Hi,
> >> >> >>>
> >> >> >>> I am newbie with bluez and I'm developing a research project where I
> >> >> >>> need to use various Bluetooth USB-dongles.
> >> >> >>>
> >> >> >>> I need to deploy an automatic bluetooth pairing by command line
> >> >> >>> (it is a
> >> >> >>> project requirement), but the problem is that bluetooth-agent does
> >> >> >>> only
> >> >> >>> listen to hci0 device (I mean, if in any case I need to pair with
> >> >> >>> any
> >> >> >>> other dongle, bluetooth-agent does not reply).
> >> >> >>>
> >> >> >>> Is there any possibility where bluetooth-agent could respond to the
> >> >> >>> other devices? The man page for bluetooth-agent is missing, and I
> >> >> >>> have
> >> >> >>> not found any way to get it.
> >> >> >>>
> >> >> >>> Thanks a lot and best regards.
> >> >> >>>
> >> >> >>>
> >> >> >>>
> >> >> >>> --
> >> >> >>> To unsubscribe from this list: send the line "unsubscribe linux-
> >> >> >>> bluetooth" in
> >> >> >>> the body of a message to majordomo@vger.kernel.org
> >> >> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >> >>>
> >> >> > --
> >> >> > Germán Pedrosa <german.pedrosa@fundacionctic.org>
> >> >> >
> >> >> > --
> >> >> > To unsubscribe from this list: send the line "unsubscribe linux-
> >> >> > bluetooth" in
> >> >> > the body of a message to majordomo@vger.kernel.org
> >> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >>
> >> >> LORENZO ANTONIO BRITO MORALES
> >> >> lorenzo.brito@gmail.com
> >> >> lorbrito.blogspot.com
> >> >>
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >> >
> >
> >

