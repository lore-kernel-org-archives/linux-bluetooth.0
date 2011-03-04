Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 15:34:25 -0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	anderson.lizardo@openbossa.org
Subject: Re: [PATCH v3] Fix response on adapter RequestSession method
Message-ID: <20110304183425.GA21452@jh-x301>
References: <1299054257-15806-1-git-send-email-dmitriy.paliy@nokia.com>
 <1299054257-15806-2-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299054257-15806-2-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Wed, Mar 02, 2011, Dmitriy Paliy wrote:
> Fixes response on adapter RequestSession method to be sent after mode
> is changed, if such is necessary. More specifically, change of power
> off mode to power on is in question.
> 
> Currently response is sent when mode change is confirmed by agent, not
> by response from controller. Such may lead to failed CreateDevice
> method if it is called quickly enough after RequestSession when
> controller is in powered off state.
> 
> New session is not created if there is already a session for such
> D-Bus message.
> ---
>  src/adapter.c |   52 +++++++++++++++++++++++++++++++++++++++++-----------
>  1 files changed, 41 insertions(+), 11 deletions(-)

Pushed upstream. Thanks.

Johan
