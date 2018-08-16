Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20180808080346.32747-1-luiz.dentz@gmail.com>
In-Reply-To: <20180808080346.32747-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Aug 2018 16:30:47 +0300
Message-ID: <CABBYNZJwA3v+2wbhGOCQzPjQmDody+_FUBTRFKirnhbA6znWog@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gitlint: Add .gitlint configuration
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On Wed, Aug 8, 2018 at 11:03 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds a configuration for gitlint matching the preferred format.
> ---
>  .gitlint | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 .gitlint
>
> diff --git a/.gitlint b/.gitlint
> new file mode 100644
> index 000000000..59ed7d605
> --- /dev/null
> +++ b/.gitlint
> @@ -0,0 +1,48 @@
> +# All these sections are optional, edit this file as you like.
> +# [general]
> +# ignore=title-trailing-punctuation, T3
> +# verbosity should be a value between 1 and 3, the commandline -v flags take precedence over this
> +# verbosity = 2
> +# By default gitlint will ignore merge commits. Set to 'false' to disable.
> +# ignore-merge-commits=true
> +# Enable debug mode (prints more output). Disabled by default.
> +# debug=true
> +
> +# Set the extra-path where gitlint will search for user defined rules
> +# See http://jorisroovers.github.io/gitlint/user_defined_rules for details
> +# extra-path=examples/
> +
> +[title-max-length]
> +line-length=72
> +
> +# [title-must-not-contain-word]
> +# Comma-separated list of words that should not occur in the title. Matching is case
> +# insensitive. It's fine if the keyword occurs as part of a larger word (so "WIPING"
> +# will not cause a violation, but "WIP: my title" will.
> +# words=wip
> +
> +# [title-match-regex]
> +# python like regex (https://docs.python.org/2/library/re.html) that the
> +# commit-msg title must be matched to.
> +# Note that the regex can contradict with other rules if not used correctly
> +# (e.g. title-must-not-contain-word).
> +# regex=^US[0-9]*
> +
> +# [B1]
> +# B1 = body-max-line-length
> +# line-length=120
> +
> +[body-min-length]
> +min-length=1
> +
> +# [body-is-missing]
> +# Whether to ignore this rule on merge commits (which typically only have a title)
> +# default = True
> +# ignore-merge-commits=false
> +
> +# [body-changed-file-mention]
> +# List of files that need to be explicitly mentioned in the body when they are changed
> +# This is useful for when developers often erroneously edit certain files or git submodules.
> +# By specifying this rule, developers can only change the file when they explicitly reference
> +# it in the commit message.
> +# files=gitlint/rules.py,README.md
> --
> 2.17.1

Applied.

-- 
Luiz Augusto von Dentz
