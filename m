Return-Path: <cyrus@holtmann.org>
Message-Id: <D94DFDBF-DAB1-4343-96F0-FFBA05A58373@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1224404909.9386.29.camel@californication>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Add application header support to gwobex
Date: Sun, 19 Oct 2008 15:36:27 +0300
References: <1224404909.9386.29.camel@californication>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Oct 19, 2008, at 11:28, Marcel Holtmann wrote:
> for the PBAP support, we need to handle the application header and for
> our client/test applications, I extended gwobex to allow us to specify
> this header. What do you think?

Looks good to me, though the parameter lists to the _get and_put  
functions are starting to grow pretty long. In general it'd be nice to  
get the same functionality into libopenobex-glib soonish since I'm not  
particularly enjoying looking at this ancient code and coding style  
that should just die away ;)

Johan
