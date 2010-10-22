Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 18:40:54 -0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: ext-tommi.keisala@nokia.comt, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when GetProperties req is received before
 any adapters are set up
Message-ID: <20101022204054.GA7797@jh-x301>
References: <1287743558-17002-1-git-send-email-ext-tommi.keisala@nokia.com>
 <1287743558-17002-2-git-send-email-ext-tommi.keisala@nokia.com>
 <20101022131207.GA29655@jh-x301>
 <AANLkTimwz0wYbiQpkPmJuNpmJxNxaAQ2UtudPqinh9kP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimwz0wYbiQpkPmJuNpmJxNxaAQ2UtudPqinh9kP@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Oct 22, 2010, Luiz Augusto von Dentz wrote:
> Maybe we should also add a check here to omit adapters if we don't
> have at least one to append, it should be fine to have empty
> containers but I don't think this is very useful for the application
> since they have to iterate in the container to find out there is in
> fact nothing there.

Wouldn't it complicate e.g. python code in that you'd need

if manager_props.has_key('Adapters'):
	for adapter in manager_props['Adapters']:
		...

to avoid triggering a KeyError exception which could happen if you try
to access manager_props['Adapters'] directly.

Johan
