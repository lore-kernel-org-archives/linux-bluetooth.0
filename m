Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Nov 2010 03:35:31 +0000
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Elvis =?iso-8859-1?Q?Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] [RFC] Add Application property to HealthChannel
Message-ID: <20101102033531.GA2662@vigoh>
References: <1288635382-2032-1-git-send-email-epx@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1288635382-2032-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Elvis Pfützenreuter <epx@signove.com> [2010-11-01 16:16:22 -0200]:

> This patch adds the Application property to HealthChannel, which
> allows to unambiguously relate a channel to an application.
> 
> This property is useful when there are several processes interested
> in accepting HealthChannels but device address is not sufficient
> criteria to engage upon, or ignore, the ChannelConnected signal.
> Having the application path allows to determine role and data type,
> in the context of the process that has created that application.
> 
> Also, channel path skeleton is fixed in documentation, in order to
> reflect atual implementation.

So a separeted patch here.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
