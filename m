Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120927074338.GC9610@x220>
References: <1348594686-26221-1-git-send-email-jprvita@openbossa.org>
	<1348594686-26221-2-git-send-email-jprvita@openbossa.org>
	<20120927074338.GC9610@x220>
Date: Fri, 28 Sep 2012 11:27:39 -0300
Message-ID: <CAKT1EBdhhqsEU9_zxcAHArtpwzzOo2hmwDmz91SrYNQeiEdEJw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 2/9] mgmt: Add LE scanning callback
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Thu, Sep 27, 2012 at 4:43 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Sep 25, 2012, João Paulo Rechi Vita wrote:
>> +int mgmt_start_scanning(int index)
>
> Firstly I don't think the name is good since BR/EDR also has the concept
> of scanning (page scan & inquiry scan). Secondly, maybe it'd be simpler
> to reuse mgmt_start_discovery and simply add a new parameter which
> provides the value for info->discov_type?
>
> Johan

My suggestions are:
1. rename to mgmt_start_le_scanning
2. add a new parameter to mgmt_start_discovery: gboolean le_only
3. add a new parameter to mgmt_start_discovery: informing the adapter
operation mode(BREDR/LE/BREDR_LE)

Option 3 will require to expose controller info/settings to adapter.c.
It is necessary to know the controller features to send the right
discover type. btd_adapter_start function could be extended to receive
the supported features or a parameter specifying the operation mode.
IMO, using this approach we are duplicating information.

Which approach do you prefer?

Regards,
Claudio.
