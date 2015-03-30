Return-Path: <cyrus@holtmann.org>
Message-ID: <55194C56.7010700@cchtml.com>
Date: Mon, 30 Mar 2015 08:15:02 -0500
From: Michael Cronenworth <mike@cchtml.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: header change affects c++ projects
References: <5517B933.1080809@cchtml.com>	<CABBYNZ+VdZkU9y2TyH_6rsM_=8tVdGNrXUp9yX5NTAjy5k06bQ@mail.gmail.com>	<55185E7F.9040604@cchtml.com> <CABBYNZJS9e2aGeX+cWnNWycvDv6XNKs-xNyoPqKLzdJrqzd-vw@mail.gmail.com>
In-Reply-To: <CABBYNZJS9e2aGeX+cWnNWycvDv6XNKs-xNyoPqKLzdJrqzd-vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 03/30/2015 02:13 AM, Luiz Augusto von Dentz wrote:
> uint128_t is a byte array:
>
> typedef struct {
> uint8_t data[16];
> } uint128_t;
>
> There is no precision loss.

Thanks, I did not see the definition.

However, the conversion of void* *must* be fixed. This is the key issue.

