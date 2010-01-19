Return-Path: <cyrus@holtmann.org>
Date: Tue, 19 Jan 2010 12:33:38 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Denis Kenzior <denkenz@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	ofono@ofono.org
Subject: Re: [RFC] HFP support into oFono and BlueZ
Message-ID: <20100119103338.GA22431@jh-x301>
References: <fbf08281001110908s2c3412m456b3aa980b8ca10@mail.gmail.com>
 <fbf08281001131539l342a3062w70883c197dc52983@mail.gmail.com>
 <2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
 <201001171637.22263.denkenz@gmail.com>
 <2d5a2c101001190130u3b73737cl2589ba04ec5abd45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101001190130u3b73737cl2589ba04ec5abd45@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Jan 19, 2010, Luiz Augusto von Dentz wrote:
> Also the problem with this being in the device path is that ofono may
> not be registered as an agent on connect (both ways) which will cause
> the connection to drop and the round trips to resolve device path only
> makes it worse, if this happen to be on adapter path this would not be
> a problem since we know before hand who to call.

I don't think this is an issue in the case of a per-adapter handsfree
agent. Typically the agent would be registered upon the creation of the
device object. Yes, in theory a HFP connection establishment may occur
before ofono manages to register an agent for the device but the
connection doesn't need to be dropped because of it. Since it's the
HF-role device (i.e. us) that sends the initial AT command in HFP SLC
establishment bluetoothd could just sit quietly waiting until an agent
registers itself. When an agent finally gets registered bluetoothd would
(after replying to the registration method call) immediately call the
NewConnection() method for the agent.

Johan
