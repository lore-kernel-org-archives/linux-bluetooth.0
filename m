Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Feb 2012 10:48:31 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: GATT improvements v3
Message-ID: <20120203184831.GA19240@x220.globalsuite.net>
References: <1327497161-14764-1-git-send-email-sancane@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327497161-14764-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Jan 25, 2012, Santiago Carot-Nemesio wrote:
> The same set of patches but including all changes suggested.
> 
> [PATCH 1/8] gatt-service: Add support for 128-bit Bluetooth UUIDs
> [PATCH 2/8] gatt-service: Move va_end just after processing the
> [PATCH 3/8] gatt-service: Provide service uuid in
> [PATCH 4/8] attrib-server: Allocate 16-bits UUIDS at the begining of
> [PATCH 5/8] attrib-server: Set database uuids as a double linked
> [PATCH 6/8] glib-compat: Add g_list_free_full to deal with issues in
> [PATCH 7/8] attrib-server: Allocate 128-bits UUIDs using highest
> [PATCH 8/8] gatt-example: Fix g_assert checks when an uint16_t value

All of these patches have been pushed upstream. Thanks.

Johan
