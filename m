Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Sep 2009 14:30:53 +0200
From: Vladimir Botka <vbotka@gmail.com>
To: bluezprofile kernel <bluezprofile@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: BlueZ Supported Profiles
Message-ID: <20090922143053.287fc8a5@vlado>
In-Reply-To: <ba5648fa0909212143g36f47acck2e4b610429c477ec@mail.gmail.com>
References: <ba5648fa0909212143g36f47acck2e4b610429c477ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 22 Sep 2009 10:13:40 +0530
bluezprofile kernel <bluezprofile@gmail.com> wrote:

> Hi,
> I would like to know what are all profiles supported by BlueZ?
> Is there any site gives list of profiles supported by BlueZ?
> I am using BlueZ 4.46.
> 

Hi,
you can see the provided services with the command:
# sdptool browse BTADDR

Get the BTADDR from the output of:
# hcitool scan

Run these command from another Linux box.
HTH,
-- 
	-vlado
	Vladimir Botka

