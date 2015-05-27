Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1427692567-631-1-git-send-email-bharat.panda@samsung.com>
 <004101d06b73$9289a650$b79cf2f0$@samsung.com>
 <CABBYNZ+wrVLJen3F1Wxx==syH325RwgUL9OcGc6ygtiwhceDkw@mail.gmail.com>
In-reply-to: <CABBYNZ+wrVLJen3F1Wxx==syH325RwgUL9OcGc6ygtiwhceDkw@mail.gmail.com>
Subject: RE: [PATCH v4] monitor: Add AVDTP support to btmon
Date: Wed, 27 May 2015 16:11:02 +0530
Message-id: <01ff01d09869$a3ee35f0$ebcaa1d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
> Sent: Tuesday, March 31, 2015 6:57 PM
> To: Bharat Bhusan Panda
> Cc: linux-bluetooth@vger.kernel.org; cpgs@samsung.com
> Subject: Re: [PATCH v4] monitor: Add AVDTP support to btmon
> 
> Hi Bharat,
> 
> On Tue, Mar 31, 2015 at 8:28 AM, Bharat Bhusan Panda
> <bharat.panda@samsung.com> wrote:
> > ping
> 
> Looks like it would be a problem for multiple devices connected since at
> assign_scid we don't have the information about the device just the psm?
> Did you try that?
Did you mean, multiple devices connected to same AVDTP case?
> 
> 
> --
> Luiz Augusto von Dentz

