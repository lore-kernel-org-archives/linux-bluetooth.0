Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<santoscadenas@gmail.com>
To: Elvis =?iso-8859-1?q?Pf=FCtzenreuter?= <epx@signove.com>
Subject: Re: Changes in HDP API
Date: Thu, 5 Aug 2010 11:29:34 +0200
Cc: linux-bluetooth@vger.kernel.org
References: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com> <0AEF6BD1-2A78-47E2-9445-87D78E4C85F8@signove.com>
In-Reply-To: <0AEF6BD1-2A78-47E2-9445-87D78E4C85F8@signove.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201008051129.38119.santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

El Wednesday 04 August 2010 20:22:29 Elvis Pfützenreuter escribió:
> On 04/08/2010, at 04:49, Jose Antonio Santos Cadenas wrote:
> > This patch makes some changes in the HDP API based in the conversation
> > that I had yesterday with Luiz and Elvis.
> > 
> > I still have a doubt about the notification of devices in the agent. Luiz
> > commented that with this API the Agent and the Application could not be
> > in different processes, is this a problem?
> 
> Is not a problem and IMHO it does not make sense at all. The Agent in HDP
> API context is as a mere vehicle for callbacks, because signals are seen
> by every process while the nature of health devices demands some
> privacy/secrecy (I have a faint memory about privacy being a general
> requirement for IEEE protocol as well as Continua certification.)

I've been thinking about this issue and I'm changing my opinion about this a 
little bit. I will expose my "new" view and later today I will send a new API 
proposal if you think this approach is OK.

In fact the privacy issue should concern to the data that is being transmitted 
over the data channel, not the creation and destruction of the data channel. 
If we start from that point. Sending new channel events as signals will not be 
a privacy problem if we protect the data channel itself.

The DataChannel object (as is defined in the current API) could be protected 
and only reply to method calls from the process owner of the application that 
waited for this data channel (if it was opened by the remote side) or from the 
creator of the data channel (if it was opened by the local side). This way 
only this process will be able to get the file descriptor (what means get 
access to the data) and to manage the connection closing, reconnecting or 
deleting the data channel. So in this way the privacy of the data is 
guaranteed.

An other thing to take into account is that all the application will be 
bothered with signals of data channel creation an deletion even when they 
could not use them. But I thing that this is not too much extra load because 
in a typical scenario only one or two application will be interested in health 
data channels.

> 
> The agent is always coupled with an application. The most typical usage of
> BlueZ HDP is as sink role, which means the application creates the
> application, which publishes the role via SDP, and sits idle until some
> source connects, which is notified via the agent.


Regards.
