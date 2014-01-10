Return-Path: <cyrus@holtmann.org>
Message-ID: <52CFB189.5040900@linux.intel.com>
Date: Fri, 10 Jan 2014 10:38:33 +0200
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH_v4 0/4] Add support for NAP role
References: <1389181593-9683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389181593-9683-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

On 01/08/2014 01:46 PM, Ravi kumar Veeramally wrote:
> v4: Fixed Szymon's and Luiz's comments.
>
> v3: Fixed Johan's comments (removed fopen, fprintf and used open and write).
>
> v2: Fixed Johan's comments.
>
> v1: This patch set add support for NAP role. It register NAP server and create
>    bnep bridge and listen for incoming connections from client devices.
>    On incoming connection request it accepts connection, creates bnep interface
>    and notifies control state and connection state infromation. Removes device
>    on disconnect request. Android related changes are required to enable this
>    role. Patches sent to respective ML.
>
> Ravi kumar Veeramally (4):
>    android/pan: Register Network Access Point
>    android/pan: Listen for incoming connections and accept in NAP role
>    android/pan: Implement PAN enable HAL api at daemon side
>    android/pan: Remove connected PAN devices on profile unregister call
>
>   android/pan.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 334 insertions(+), 12 deletions(-)
>

