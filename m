Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Tue, 29 Apr 2014 03:21:06 +0200
Message-ID: <CAMudyAvKvdHwmA8UxXfb5udt3va8z3ZnPwanwbXXmzkCEyFYfQ@mail.gmail.com>
Subject: Re: [PATCH 00/36] android/gatt: GATT server implementation
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Szymon Janc <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On 29 April 2014 03:14, Lukasz Rymanowski <lukasz.rymanowski@tieto.com> wrote:
> This patch set adds major part of GATT server support for Android:
> * GATT database extension to get, read and write data
> * Handling GATT Server Android requests
> * Create listening socket for BLE.
> * Support GATT Service
> * Support Device Information Service
> * Support Service Changed (skeleton)
> * some bugfixes
>
> Still some improvements are needed.
>
> Tested on PC and Nexus 5 as peripheral device.
>

Forgot to mention that for now we do handle ATT requests in android
folder but once bt_att will be ready we will move to use that io.

> Grzegorz Kolodziejczyk (3):
>   android/gatt: Add support for ATT read by type
>   android/gatt: Add MTU request cmd handling
>   android/gatt: Add Find info gatt server cmd handling
>
> Jakub Tyszkowski (3):
>   android/gatt: Add comment about event type being sent
>   android/gatt: Register device information service
>   android/gatt: Register GATT service
>
> Lukasz Rymanowski (20):
>   android/gatt: Add listening socket for GATT
>   android/gatt: Add ATT msg handler
>   shared: Use pointer for request data instead of int
>   shared/gatt: Extend read callback with offset
>   android/gatt: Add register GAP Service
>   gatt: Add some characteristics uuids
>   shared: Extend write callback with offset
>   android/gatt: Add support for ATT read by group type
>   shared/gatt: Add support to read from database
>   android/gatt: Move struct req_data up in the file
>   android/gatt: Add support to read request
>   shared/gatt: Add support for write request
>   android/gatt: Add support for write request
>   android/gatt: Add support for execute write
>   android/gatt: Move struct req_data upper in the file
>   android/gatt: Add write callback to server
>   android/gatt: Add read_cb for GATT Server
>   android/hal-gatt-api: Fix IPC definition for send response
>   android/gatt: Add support for GATT server send response
>   android/gatt: Add support for send indication
>
> Marcin Kraglak (10):
>   android/gatt: Add service functionality
>   android/gatt: Add implementation of delete service
>   android/gatt: Add included service implementation
>   android/gatt: Add characteristic implementation
>   android/gatt: Add handling of start service command
>   android/gatt: Add stop service command handling
>   android/gatt: Add descriptor implementation
>   shared/gatt: Add function to read by group type
>   shared/gatt: Add function to find by type
>   shared/gatt: Add function to read by type
>
>  android/gatt.c       | 1176 +++++++++++++++++++++++++++++++++++++++++++++++---
>  android/hal-gatt.c   |    7 +-
>  android/hal-msg.h    |    3 +
>  lib/uuid.h           |    7 +
>  src/shared/gatt-db.c |  320 ++++++++++++++
>  src/shared/gatt-db.h |   62 ++-
>  6 files changed, 1515 insertions(+), 60 deletions(-)
>
> --
> 1.8.4
>

\Lukasz
