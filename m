Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CALE9AOZkUqp=NJWxiOPtadFmbZvRS9FexH53yeCcqKXMWyuesQ@mail.gmail.com>
References: <CALE9AOZkUqp=NJWxiOPtadFmbZvRS9FexH53yeCcqKXMWyuesQ@mail.gmail.com>
Date: Thu, 24 May 2012 14:42:33 +0200
Message-ID: <CACLukzL9WJtE330wLQoPbkN2A6=rtqJEMKsnzS7KZFohYvygag@mail.gmail.com>
Subject: Re: help with mcap/csp ??
From: Santiago Carot <sancane@gmail.com>
To: Howard <hpage66@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Howard,

2012/5/23 Howard <hpage66@gmail.com>:
> Does anyone have any  demo code (c/c++) that shows me how to sync two
> linux machines' clocks with bluetooth bluez mcap/csp? Thanks!
>

The way in which profiles are used in BlueZ is through a well defined
D-Bus API. MCAP is developed as a service library ready to be used by
profiles that require it, at present, as far as I know only HDP uses
it. So if you are planning to use MCAP from outside of BlueZ you
should develop a plugin which exports all functionalities you want in
MCAP through a DBUS API so that you can interact with it.

Regards.
