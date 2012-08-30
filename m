Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Chen Ganir <chen.ganir@ti.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] gatt: Translate Characteristic names
Date: Thu, 30 Aug 2012 14:43:57 +0200
Message-ID: <1652968.T8pSJl1pGy@uw000953>
In-Reply-To: <503F5EAC.4070909@ti.com>
References: <1346237776-12781-1-git-send-email-chen.ganir@ti.com> <1472845.YqRC14yUFc@uw000953> <503F5EAC.4070909@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 30 of August 2012 15:38:04 Chen Ganir wrote:

> >>   static GSList *gatt_services = NULL;
> >>
> >> +static const struct characteristic_info *get_char_info(const char* uuid)
> >
> > I would leave this function returning name directly and not whole struct characteristic_info.
> >
> Why ? We have this struct with characteristic information (maybe later 
> we'll add more information. Why limit ourselves to name only ?

If you plan to add more data into that structure then it is OK to return whole struct.
But if only name is to be used, then I would just call that function get_name() and
return name.

-- 
BR
Szymon Janc
