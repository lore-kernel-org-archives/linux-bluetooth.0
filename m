Return-Path: <cyrus@holtmann.org>
Message-ID: <4E536DFF.8050205@invoxia.com>
Date: Tue, 23 Aug 2011 11:08:15 +0200
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: HFP gateway and new incoming connection
References: <4E528879.5080103@invoxia.com>	<20110822174912.GA21949@joana> <CABBYNZLEkc8FWmJm9hU_n-KL2mhWeWPcUfxqX1jskH8ubU-aMw@mail.gmail.com>
In-Reply-To: <CABBYNZLEkc8FWmJm9hU_n-KL2mhWeWPcUfxqX1jskH8ubU-aMw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08/22/2011 09:58 PM, Luiz Augusto von Dentz wrote:
> [...]
> Yep, we have some plans to move the Agent registration to adapter
> path, so it gonna be per adapter. This is necessary to set the
> features bit properly in the record and probably gonna support both
> roles (with different agents). My initial idea was to use Media API,
> but perhaps is confusing since HFP is not entirely about audio but
> call control too (mostly) so perhaps we gonna have a different
> interface for it e.g. org.bluez.Telephony, in addition to that we are
> planning to pass the endpoint bus and path together in the
> NewConnection so the telephony agent (oFono) can communicate directly
> to endpoint in use (PulseAudio).
>
> Those are my plans, but none of this is set in stone and Im pretty
> open for ideas
>

what about using the org.bluez.Adapter / RegisterAgent API, and add:
- the possibility to setup multiple agents (maintain a list of agents)
- use the "capability" field as a filter definition to find the good 
agent for the particular request
ex:
     audio/gateway.c::agent_sendfd() will look for a agent in the list, 
with a "HFP" capability to send the "NewConnection" request

Arnaud
