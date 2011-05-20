Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3 1/2] Fix change to numbers GSlist in new missed calls
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: ext Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20110519233401.GB4016@dell.ger.corp.intel.com>
References: <1305809864-9963-1-git-send-email-dmitriy.paliy@nokia.com>
	 <1305809864-9963-2-git-send-email-dmitriy.paliy@nokia.com>
	 <20110519233401.GB4016@dell.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 May 2011 09:51:48 +0300
Message-ID: <1305874308.2501.9.camel@dp-x301>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Both patches have been pushed upstream. Could you still explain what
> data->numbers is supposed to be useful for? It's not used anywhere in
> the code (except where creating and freeing the list).

Thanks.

data->numbers is used in pull_newmissedcalls to store missed calls
numbers that were checked by user. It is updated when starts reading
response, and cleared when completed. Therefore,
free_data_numbers(data); is done also in _finalize function also for the
sake of safety if PBAP object is destroyed before the list if freed.

BR,
Dmitriy


