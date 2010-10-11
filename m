Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Oct 2010 22:31:54 +0100
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Pull request git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git
 for_upstream
Message-ID: <20101011213154.GA12131@jh-x301>
References: <AANLkTi=Ogzb3kUX7O4fz-w9gNpU9PCyTFo0GnhfePjC6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=Ogzb3kUX7O4fz-w9gNpU9PCyTFo0GnhfePjC6@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Oct 11, 2010, Jose Antonio Santos Cadenas wrote:
> The following changes since commit 646f0c7e6b557c5413825ce7b04bee52bf0129e8:
> 
>   Move remote name and version requests to hciops (2010-10-10 22:44:25 +0100)
> 
> are available in the git repository at:
>   git://gitorious.org/bluez-mcap-hdp/mcap-hdp.git for_upstream
> 
> José Antonio Santos Cadenas (6):
>       Remove mdl_conn from struct hdp_channel
>       Remove app paramter from hdp_establish_mcl, it is not needed
>       Imcoming connection in control channel should be ERTM
>       Fix multiple emission of main channel property signal.
>       Return MCAP_MDL_BUSY when health channel can't be created
>       Implement callback for responding echo petitions
> 
> Santiago Carot-Nemesio (6):
>       Add a new function to create channels
>       Process request of of echo channels creation
>       Correctly notify the deletion of the reliable data channel
>       Add extra checks for avoid notifiying incoming echo channels
>       Delete all channels DBus interface when the instance is removed
>       Check first reliable configuration during channel creation
> 
>  health/hdp.c       |  249 +++++++++++++++++++++++++++++++++++----------------
>  health/hdp_types.h |    3 +-
>  health/hdp_util.c  |    3 -
>  health/hdp_util.h  |    1 -
>  health/mcap.c      |    1 +
>  5 files changed, 174 insertions(+), 83 deletions(-)

Could you try to ping me on IRC when possible so we can solve a few
issues with these patches. It seems e.g. that you're doing GIOChannel
reference counting incorrectly in one place. There are also some english
language errors in the commit messages that would be good to fix (let's
see if you can spot them yourselves, otherwise I'll point them out when
we go over the other issues ;)

Johan
