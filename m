Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: Re: [PATCH v4 00/38] android/gatt: GATT server implementation
Date: Wed, 30 Apr 2014 17:31:35 +0200
Message-ID: <1402229.mYdsSYSnjX@uw000953>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 30 of April 2014 11:13:31 Lukasz Rymanowski wrote:
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
> v2:
> * Handled comments from Johan
> * Added complete callback to database requests
> * some bugfixes found during tests with haltest
> * Rebase on upstream
> 
> v3:
> * fixed android/gatt: Add support for send indication
> 
> v4:
> * simplify communication between gatt server and database
> * Some bugfixes 
> 
> Grzegorz Kolodziejczyk (3):
>   android/gatt: Add support for ATT read by type
>   android/gatt: Add MTU request cmd handling
>   android/gatt: Add Find info gatt server cmd handling
> 
> Jakub Tyszkowski (3):
>   android/gatt: Remove redundant find function parameter
>   android/gatt: Register device information service
>   android/gatt: Register GATT service
> 
> Lukasz Rymanowski (21):
>   android/gatt: Rename listen_clients to listen_apps
>   android/gatt: Add listening socket for GATT
>   android/gatt: Assume that each server wants waits for connection
>   android/gatt: Add ATT msg handler
>   shared/gatt: Use bdaddr instead of request_id
>   shared/gatt: Extend read/write callback with offset
>   shared/gatt: Add att_opcode to read/write callback
>   android/bluetooth: Add function for getting device Android name
>   android/gatt: Add register GAP Service
>   gatt: Add some characteristics uuids
>   android/gatt: Add support for ATT read by group type
>   shared/gatt: Add support to read from database
>   android/gatt: Add support to read request
>   shared/gatt: Add support for write request
>   android/gatt: Add support for write request
>   android/gatt: Add support for execute write
>   android/gatt: Add write_cb to GATT server
>   android/gatt: Add read_cb for GATT Server
>   android/hal-gatt-api: Fix IPC definition for send response
>   android/gatt: Add support for GATT server send response
>   android/gatt: Add support for send indication
> 
> Marcin Kraglak (11):
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
>   shared/gatt: Add function to find information
> 
>  android/bluetooth.c  |    5 +
>  android/bluetooth.h  |    1 +
>  android/gatt.c       | 1249 +++++++++++++++++++++++++++++++++++++++++++++++---
>  android/hal-gatt.c   |    7 +-
>  android/hal-msg.h    |    3 +
>  lib/uuid.h           |    7 +
>  src/shared/gatt-db.c |  322 +++++++++++++
>  src/shared/gatt-db.h |   60 ++-
>  8 files changed, 1577 insertions(+), 77 deletions(-)
> 
> 

A modified version of this patchset is now pushed upstream.

-- 
Best regards, 
Szymon Janc
