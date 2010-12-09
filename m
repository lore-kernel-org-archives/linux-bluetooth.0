Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Dec 2010 12:19:50 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/3 v4] Cancel pending phonebook request
Message-ID: <20101209101950.GA23258@jh-x301>
References: <1291889119-23915-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291889119-23915-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Thu, Dec 09, 2010, Dmitriy Paliy wrote:
> Structure context_query changed to query_context in phonebook-ebook.c
> comparing to previous submission, and phonebook_req_cancel changed to
> phonebook_req_finalize.
> 
> More comments added to phonebook.h.

Thanks for the update. All three patches have been pushed upstream.

Johan
