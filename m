Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327497161-14764-1-git-send-email-sancane@gmail.com>
References: <1327497161-14764-1-git-send-email-sancane@gmail.com>
Date: Fri, 3 Feb 2012 09:37:35 +0100
Message-ID: <CACLukzJ+daOKbF4JrNg_8uDLrwAzWtP2Db91C9AUL4z7r6DF7A@mail.gmail.com>
Subject: Re: GATT improvements v3
From: Santiago Carot <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

2012/1/25 Santiago Carot-Nemesio <sancane@gmail.com>:
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
