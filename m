Return-Path: <cyrus@holtmann.org>
Subject: Re: Changes in HDP API
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
Date: Wed, 4 Aug 2010 15:22:29 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0AEF6BD1-2A78-47E2-9445-87D78E4C85F8@signove.com>
References: <1280908152-3743-1-git-send-email-santoscadenas@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 04/08/2010, at 04:49, Jose Antonio Santos Cadenas wrote:

> This patch makes some changes in the HDP API based in the conversation that I
> had yesterday with Luiz and Elvis.
> 
> I still have a doubt about the notification of devices in the agent. Luiz
> commented that with this API the Agent and the Application could not be in
> different processes, is this a problem?

Is not a problem and IMHO it does not make sense at all. The Agent in HDP API context is as a mere vehicle for callbacks, because signals are seen by every process while the nature of health devices demands some privacy/secrecy (I have a faint memory about privacy being a general requirement for IEEE protocol as well as Continua certification.)

The agent is always coupled with an application. The most typical usage of BlueZ HDP is as sink role, which means the application creates the application, which publishes the role via SDP, and sits idle until some source connects, which is notified via the agent.