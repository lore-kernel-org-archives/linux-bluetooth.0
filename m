Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Oct 2014 16:50:00 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Min Jun,Xi" <xi.minjun@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: BT-4.1 features (e.g. concurrent GAP operations) support
Message-ID: <20141015145000.GA26735@t440s.fdxtended.com>
References: <CAB0Wyv=3HBi6wnStgjGFwg7HUODoYj3mZBVTnZnC+tb+Mipyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAB0Wyv=3HBi6wnStgjGFwg7HUODoYj3mZBVTnZnC+tb+Mipyxw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 15, 2014, Min Jun,Xi wrote:
> Where can I find the latest BT-4.1 features support for
> Bluetooth-subsystem and BlueZ?

I don't think the detailed feature status is documented anywhere but the
code, so the most reliable way would be to get the latest user space and
kernel trees and experiment with them yourself.

> In the 4.1 features, I know connection-oriented channels has been supported;
> 
> I have one question about this new feature (Bluetooth Specification
> Version 4.1[Vol 3] page 293 of 668, ): "2.2.2.5 Concurrent Operation
> in Multiple GAP Roles"; this feature is very useful to support
> mesh-like topology,
> 
> From the description in chapter 2.2.2.5, the controller should support
> operations in multiple GAP roles concurrently, and the host should
> read the supported Link Layer States and State combinations from the
> Controller before any procedures or modes are used.
> 
> Can anyone tell me if the bluetooth subsystem has supported the Link
> Layer states and the States combinations? I am also looking for the
> Controller support operations in multiple GAP roles concurrently, can
> anyone know if CSR/Nordic/Broadcom has got the USB dongles which
> supports concurrent operation and can used under Linux?

We don't specifically look at the controller supported states at the
moment but simply stick to what we know existing controllers to be
capable of. This means that you will be able to both scan and advertise
at the same time (i.e. act as central and peripheral). What we do limit
(since we don't know if HW that supports it) is new LE connection
creation when there already is an existing slave-role connection.

Johan
