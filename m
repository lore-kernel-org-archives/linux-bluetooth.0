Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix incorrect device name in the wizard
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1224798058.2895.209.camel@cookie.hadess.net>
References: <1224798058.2895.209.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 20:57:49 +0100
Message-Id: <1225137469.7157.34.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> When the device is selected in the list before its name is resolved,
> the device name in the checks as well as the final page of the wizard
> will be wrong.

patch has been applied, but I am worried about increasing the reference
count of the agent and never decreasing it. Do you think that is a good
idea?

Regards

Marcel


