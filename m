Return-Path: <cyrus@holtmann.org>
Message-ID: <1348842803.13371.25.camel@aeonflux>
Subject: Re: [RFC] Convert storage to use per-remote device directories
From: Marcel Holtmann <marcel@holtmann.org>
To: Frederic Danis <frederic.danis@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 28 Sep 2012 16:33:23 +0200
In-Reply-To: <50642389.40107@intel.com>
References: <50642389.40107@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Here is my proposal for new storage directory structure using ini-file 
> format.
> 
> Each adapter directory (/var/lib/bluetooth/<adapter address>/) will 
> contain a config file for the local adapter and one directory per remote 
> device.
> The adapter config file just need to be converted to ini-file format 
> with only 1 group called [adapter].
> 
> Each of remote device directories' name will be based on remote device 
> address and address type (address#type).
> This directory will contain a config file with remote device infos and a 
> linkkey file.
> Remote device config file will include a [device] group with general 
> device infos (name, alias, profiles or services list, ...), and groups 
> named by profile uuid (or service uuid) with related infos.
> 
> So the directory structure should be:
>     /var/lib/bluetooth/<adapter address>/
>         ./config
>         ./<remote device address#type>/
>             ./config
>             ./linkkey
>         ./<remote device address#type>/
>             ./config
>             ./linkkey
>         ...

why do we care about the address type here? Can we actually have a
different link key for BR/EDR and for LE? Right now it is really only
one choice on how to use that remote device. If it is dual-mode, then we
use BR/EDR and if it is single-mode we use LE.

Regards

Marcel


