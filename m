Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2CF57A644018A745B8FE029C7223E16E0FD7924A@SHSMSX102.ccr.corp.intel.com>
References: <2CF57A644018A745B8FE029C7223E16E0FD7924A@SHSMSX102.ccr.corp.intel.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 25 Jun 2012 12:59:54 -0300
Message-ID: <CAMOw1v61pPwKq+3AG9wZpEYrBHxqtM4ZB2sWiFJnyKigd1W=rA@mail.gmail.com>
Subject: Re: using simple-player for testing avrcp
To: "Zheng, Wu" <wu.zheng@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 23, 2012 at 4:03 PM, Zheng, Wu <wu.zheng@intel.com> wrote:
> Hi,
>
> I want to use simple-player for testing avrcp.
>
> Run the following step in control device.
>
> 1.Use the "connect" method of org.bluez.AudioSource to connect target device.
>
> 2.Use simple-player to test avrcp.

Call "Connect" on Control interface (you need to enable it in your
/etc/bluetooth/audio.conf file)

or... let "AutoConnect=true"  in this file and call Connect on Audio interface

Lucas De Marchi
