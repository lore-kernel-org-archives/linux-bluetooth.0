Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100119103338.GA22431@jh-x301>
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com>
	 <fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com>
	 <2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
	 <201001171637.22263.denkenz@gmail.com>
	 <2d5a2c101001190130u3b73737cl2589ba04ec5abd45@mail.gmail.com>
	 <20100119103338.GA22431@jh-x301>
Date: Tue, 19 Jan 2010 14:26:51 +0200
Message-ID: <2d5a2c101001190426y71683193qbe4b132393a9d01f@mail.gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Denis Kenzior <denkenz@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	ofono@ofono.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Jan 19, 2010 at 12:33 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, Jan 19, 2010, Luiz Augusto von Dentz wrote:
>> Also the problem with this being in the device path is that ofono may
>> not be registered as an agent on connect (both ways) which will cause
>> the connection to drop and the round trips to resolve device path only
>> makes it worse, if this happen to be on adapter path this would not be
>> a problem since we know before hand who to call.
>
> I don't think this is an issue in the case of a per-adapter handsfree
> agent. Typically the agent would be registered upon the creation of the
> device object. Yes, in theory a HFP connection establishment may occur
> before ofono manages to register an agent for the device but the
> connection doesn't need to be dropped because of it. Since it's the
> HF-role device (i.e. us) that sends the initial AT command in HFP SLC
> establishment bluetoothd could just sit quietly waiting until an agent
> registers itself. When an agent finally gets registered bluetoothd would
> (after replying to the registration method call) immediately call the
> NewConnection() method for the agent.

Well it might work, but does it worth? Also I got the impression that
this is not optimal, specially if the we are simulating a combo device
hfp+a2dp this may delay the setup indefinitely until somebody register
an agent , so if I got it right our current code behind Audio.Connect
will not even attempt to connect the sink until headset state
transition from connecting.

Maybe and being paranoid, but I guess this might be troublesome for
mobile hardware where dbus is not that fast.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
