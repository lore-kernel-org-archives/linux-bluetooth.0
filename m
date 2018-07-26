Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Cinaed Simson <cinaed.simson@gmail.com>
Subject: Re: print_bitfield
To: linux-bluetooth@vger.kernel.org
References: <4b6731b3-a13c-babf-8ccf-2e1d68150521@GMail.COM>
Message-ID: <838088d7-5df0-23a1-5508-e24a9ef257bb@GMail.COM>
Date: Thu, 26 Jul 2018 00:50:09 -0700
MIME-Version: 1.0
In-Reply-To: <4b6731b3-a13c-babf-8ccf-2e1d68150521@GMail.COM>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Oops - I had to leave the

  struct bitfield_data

in

  monitor/display.h

and move

  inline uint64_t print_bitfield()

from display.h to

   monitor/packet.c

-- Cinaed

On 07/25/2018 11:10 PM, Cinaed Simson wrote:
> 
> After installing ell, the latest git version builds on jessie provided I
> move both
> 
>    struct bitfield_data
>    inline uint64_t print_bitfield()
> 
> from
> 
>    monitor/display.h
> 
> to near the top of
> 
>    monitor/packet.c
> 
> Jessie is using
> 
>    gcc (Debian 4.9.2-10+deb8u1) 4.9.2
> 
> - maybe it's a compiler problem with jessie?
> 
> -- Cinaed
> 

