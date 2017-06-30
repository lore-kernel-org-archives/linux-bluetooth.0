Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Support to change set file via arg
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALM0h1m69=96tC+rM_-rXhc-9Kytaw_mZzc99vKXYZvVyjCXjg@mail.gmail.com>
Date: Fri, 30 Jun 2017 20:05:04 +0200
Cc: linux-bluetooth@vger.kernel.org, Simon Glass <sjg@chromium.org>
Message-Id: <DA80AA76-29A0-4C69-8BEF-355A3C953821@holtmann.org>
References: <20170630172920.1968-1-shapiroc@chromium.org>
 <5A47203A-A671-4854-9EAB-B09B15AF7680@holtmann.org>
 <CALM0h1m69=96tC+rM_-rXhc-9Kytaw_mZzc99vKXYZvVyjCXjg@mail.gmail.com>
To: Charles Shapiro <shapiroc@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Charles,

> For ChromeOS, we're working towards having a single build/image based
> on a reference board that then supports multiple models created by
> OEMs.
> 
> Some of the bluetooth config differs on a per model basis, so we need
> to have multiple *.conf files ship on the actual image.
> 
> We then modify the init script to check the model at runtime and pass
> the appropriate *.conf file to bluetoothd when it is started.

what are the difference in the config file? I am currently failing to see what you could change across different models. I like to understand this first before applying the everything is a nail approach here.

Regards

Marcel

