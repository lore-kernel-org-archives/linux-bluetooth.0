Return-Path: <cyrus@holtmann.org>
Message-ID: <2ec0d2a2febdbcf4ab73812ad709f542.squirrel@www.codeaurora.org>
In-Reply-To: <c2cb901974d908ed9f808324e4b4f6fb.squirrel@www.codeaurora.org>
References: <3b53a90114d801b0adba526895deed74.squirrel@www.codeaurora.org>
    <20101209144103.GA30557@jh-x301>
    <AANLkTik78DiC7TgWtR0q=xPs+ZZq470_md-gJWv8tB8f@mail.gmail.com>
    <20101210103242.GA21860@jh-x301>
    <c2cb901974d908ed9f808324e4b4f6fb.squirrel@www.codeaurora.org>
Date: Fri, 10 Dec 2010 04:19:33 -0800 (PST)
Subject: Re: A2DP reconfigure with BMW Carkit (supporting multi streams)    
       timeouts.
From: roystonr@codeaurora.org
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
	"Johan Hedberg" <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, roystonr@codeaurora.org,
	skrovvid@codeaurora.org, rshaffer@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan/Luiz,

> On Fri, Dec 10, 2010, Luiz Augusto von Dentz wrote:
> I guess it would be better to have the call to
> avdtp_stream_get_remote_sep on close_cfm, it is probably safer to do
> there and less code too, but the fix is probably right.

Along with this as per my understanding, struct avdtp_remote_sep *rsep has
to be added as member to struct a2dp_setup and rsep should be overridden
as follows in a2dp_reconfigure after call to avdtp_get_seps which returns
the sep corresponding to the stream not in use. If the remote device
supports multi-stream then sep returned would be based on the order of
get_capabilities response. Hence the following override is needed to
ensure that closed stream is reconfigured. Correct me if mistaken.

if (setup->rsep) {
  rsep = setup->rsep;
}

Have provided the patch to the tester to verify as we don't have the BMW
CK available locally. Would update the feedback received.

Regards,
Royston Rodrigues



