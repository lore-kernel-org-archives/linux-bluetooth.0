Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111202112957.GC17203@x220.ger.corp.intel.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
	<20111202112957.GC17203@x220.ger.corp.intel.com>
Date: Fri, 2 Dec 2011 12:43:24 +0100
Message-ID: <CACLukzK1YyqBszGc679Vj-Pf9+M+s+LaBpnd2_+pan8TCwHODA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Provide return status in gatt_service_add function
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

2011/12/2 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Thu, Nov 24, 2011, Santiago Carot-Nemesio wrote:
>> Service plugins using the new GATT API may need to know if their attributes
>> were successfuly retgistered. In this way, plugins might abort loading
>> operation if they weren't registered.
>> ---
>>  attrib/gatt-service.c |   15 +++++++++------
>>  attrib/gatt-service.h |    2 +-
>>  2 files changed, 10 insertions(+), 7 deletions(-)
>
> Both patches applied after fixing typos in your commit messages. Thanks.
>

When I was working in this stuff, I was wondering if there may exist
the case when a plugin registers several services and the last one
fails, Do you think it would have sense to provide the service ID as
return parameter to allow plugins remove their attributes before
aborting the loading operation?, On the other hand, this feature would
raise the posibility of finding gaps in the distribution of handlers
assigned in GATT due that plugins could add and remove services
dynamically, I'm not sure if that is expected in GATT.

Waiting comments.
Regards
