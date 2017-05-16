Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 16 May 2017 17:24:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Natalya Rozhnova <rozhnova.natalya@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Understanding Bluez mgmt events
Message-ID: <20170516142414.GA9507@x1c>
References: <CAMybWM3jHv75hrixjk3Ep8Er7Qkw8T5peKTN6SNE3qJLg9n2eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMybWM3jHv75hrixjk3Ep8Er7Qkw8T5peKTN6SNE3qJLg9n2eg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Natalya,

On Tue, May 16, 2017, Natalya Rozhnova wrote:
> I'm trying to understand the mgmt events in Bluez.
> If I understand correctly, the MGMT_OP_... commands are first sent as following:
> 
> mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY, ...)
> 
> And then it should trigger a corresponding event like
> MGMT_EV_DISCOVERING, MGMT_EV_DEVICE_FOUND etc.
> 
> I'm quite lost in understanding who, where and how generates these
> MGMT_EV... events...
> Could anybody please explain this on a simple example or showing a
> piece of code in bluez sources where it is done...

The mgmt protocol is a protocol between user space and the kernel. User
space (normally bluetoothd) sends commands to the kernel, and the kernel
sends events to user space. You can find the kernel-side implementation
in net/bluetooth/mgmt.c.

Johan
