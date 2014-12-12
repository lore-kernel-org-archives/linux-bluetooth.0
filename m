Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418221031-4379-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221031-4379-1-git-send-email-luiz.dentz@gmail.com>
Date: Fri, 12 Dec 2014 16:34:02 +0200
Message-ID: <CABBYNZKO=bobZA_e3r15xt0oBy4r=WVcbutgG=oJSZrmZg_UFg@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Simplify notification handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 10, 2014 at 4:16 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This attempts to simplify notification handling by making queue_foreach
> safe from entry removals during callback. In addition to that a couples
> there are a couple of new unit test to emulate removal during event
> callback and because of that Ive also included the coverage support again
> since I used it to check what part of the code is being exercised.
>
> v2: Make coverage target depend on lcov to be present and update test
> coverage.
>
> Luiz Augusto von Dentz (13):
>   build: Add coverage support
>   unit/test-queue: Add /queue/foreach_remove test
>   unit/test-queue: Add /queue/foreach_remove_backward test
>   shared/queue: Add reference counting to entries
>   unit/test-mgmt: Add /mgmt/response/1 test
>   unit/test-mgmt: Add /mgmt/response/2 test
>   unit/test-mgmt: Add /mgmt/event/1 test
>   unit/test-mgmt: Add /mgmt/event/2 test
>   unit/test-mgmt: Add /mgmt/unregister/1 test
>   unit/test-mgmt: Add /mgmt/unregister/2 test
>   unit/test-mgmt: Add /mgmt/destroy/1 test
>   shared/mgmt: Remove unnecessary code
>   doc: Update mgmt-tester test coverage
>
>  .gitignore            |   4 +
>  Makefile.am           |  20 +++++
>  acinclude.m4          |   4 +
>  configure.ac          |   5 ++
>  doc/test-coverage.txt |   4 +-
>  src/shared/mgmt.c     |  89 +++-----------------
>  src/shared/queue.c    |  77 +++++++++++-------
>  unit/test-mgmt.c      | 220 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  unit/test-queue.c     |  46 +++++++++++
>  9 files changed, 356 insertions(+), 113 deletions(-)
>
> --
> 1.9.3

Applied.


-- 
Luiz Augusto von Dentz
