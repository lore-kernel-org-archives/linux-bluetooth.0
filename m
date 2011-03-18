Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix adapter drivers unload order
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: ext Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
In-Reply-To: <1300448640.2478.0.camel@novo.hadess.net>
References: <1300436729-3578-1-git-send-email-dmitriy.paliy@nokia.com>
	 <1300448640.2478.0.camel@novo.hadess.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Mar 2011 13:59:01 +0200
Message-ID: <1300449541.2484.5.camel@dp-x301>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > -	adapter->loaded_drivers = g_slist_prepend(adapter->loaded_drivers,
> > -									driver);
> > +	adapter->loaded_drivers = g_slist_append(adapter->loaded_drivers,
> > +								driver);
> 
> That's usually g_slist_prepend() followed by a g_slist_reverse(), not a
> g_slist_append().

In this case append looks more appropriate if we want to be consistent
with rest of code. To be more specific with audio_manager_init and
audio_manager_exit, and btd_register_adapter_driver where drivers are
appended
adapter_drivers = g_slist_append(adapter_drivers, driver);

BR,
Dmitriy


