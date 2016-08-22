Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: BLE Hexiwear connection fail
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAOsEZohrTsrZuLxpfRQ37mVcXGDqO+rV6TzfzR1ELbSHe0jtng@mail.gmail.com>
Date: Mon, 22 Aug 2016 04:51:34 -0400
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8CD08159-2E3B-4663-9C49-56131BB77AFA@holtmann.org>
References: <CAOsEZohrTsrZuLxpfRQ37mVcXGDqO+rV6TzfzR1ELbSHe0jtng@mail.gmail.com>
To: Jay Aurabind <jay.aurabind@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay,

> I have the IoT device Hexiwear[1], which connects through BLE. They
> have an android app which can take data from it. I want to use from my
> linux machine. Its BLE API is provided at their github[2] page.

does it work on Android? If so, then enable Bluetooth HCI tracing/logging in Android and send around the /sdcard/btsnoop_hci.log file. You can read that wit btmon by yourself and compare.

I would also propose you start using btmon instead of hcidump.

Regards

Marcel

